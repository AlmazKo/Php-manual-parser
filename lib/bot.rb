# To change this template, choose Tools | Templates
# and open the template in the editor.

class Bot
  
  include Net
  
  PHP_NET_URL = 'http://php.net'
  MANUAL_URL  = PHP_NET_URL + '/manual/en/'

  NUMBER_PARSERS     = 3
  NUMBER_DOWNLOADERS = 2
  
  @@pages   = []
  
  @@download_task_queue = SizedQueue.new(NUMBER_DOWNLOADERS)
  @@parsing_task_queue = SizedQueue.new(NUMBER_PARSERS)
  @@raw_url_queue = Queue.new
  
  @@mutex = Mutex.new

  def initialize
    
    @storage = Storage.new
    
    DownloadManager.workers = 2
    ParsingManager.workers = 4
    @downloader_manager = DownloadManager.new @@download_task_queue, @@parsing_task_queue
    @parser_manager = ParsingManager.new @@parsing_task_queue, @@raw_url_queue
    @url_analyzer = Analyzer.new @@raw_url_queue, @@download_task_queue
    
  end
  
  def start
    url = URI.parse(MANUAL_URL)
    request = @php_net.get_request(url)


    result = HTTP.start(url.host, url.port) {|http|
      http.request(request)
    }

    @@finished_pages << MANUAL_URL
    @@finished_pages << (MANUAL_URL + 'index.php')
    
    # start dispatcher parsing daemon
    # start dispatcher download daemon
    parsing result
  end
  
  private
  
  def parsing html_raw

    html = Nokogiri::HTML(html_raw.body)

    html.css('a').each do |link|
  
      link_href = link.attr('href')
      url_finally = ''
      if (link_href[0] == '/')
        next unless link_href.start_with?('/manual/en')
        url_finally << PHP_NET_URL << link_href
      else
        # TODO сделать более гибкое условие
        next if link_href.start_with?('http://')
        url_finally << MANUAL_URL << link_href  
      end
 
      puts url_finally
      @@mutex.synchronize {
        if (@@finished_pages[url_finally] or @@planned_pages[url_finally])
          @@planned_pages << url_finally
        end
      }
    end
  end
end