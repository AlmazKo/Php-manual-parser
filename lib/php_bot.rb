# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'download_manager'
require 'parsing_manager'
require 'analyzer'
require 'models/index'
class PhpBot

  PHP_NET_URL = 'http://php.net'
  MANUAL_URL  = PHP_NET_URL + '/manual/en/'
  INDEX = Index.new
  attr_reader  :download_task_queue,
               :parsing_task_queue,
               :downloader_manager,
               :parser_manager,
               :url_analyzer;

  @@mutex = Mutex.new

  def initialize downloader_workers = 1, parsing_workers = 1

    @download_task_queue = SizedQueue.new downloader_workers
    @parsing_task_queue = SizedQueue.new parsing_workers
    @raw_url_queue = Queue.new


    @downloader_manager = DownloadManager.new @download_task_queue, INDEX
    @parser_manager = ParsingManager.new @parsing_task_queue, @raw_url_queue
    @url_analyzer = Analyzer.new @raw_url_queue, @download_task_queue
  end

  def start anchor
    index = Index.new
    anchors = index.get_anchors

    if anchors.empty?
      @download_task_queue.enq(anchor)
    else
      anchors.each { |anchor|
        @download_task_queue.enq(anchor)
      }
    end

  end

  #private
  #
  #def parsing html_raw
  #
  #  html = Nokogiri::HTML(html_raw.body)
  #
  #  html.css('a').each do |link|
  #
  #    link_href = link.attr('href')
  #    url_finally = ''
  #    if (link_href[0] == '/')
  #      next unless link_href.start_with?('/manual/en')
  #      url_finally << PHP_NET_URL << link_href
  #    else
  #      # TODO сделать более гибкое условие
  #      next if link_href.start_with?('http://')
  #      url_finally << MANUAL_URL << link_href
  #    end
  #
  #    puts url_finally
  #    @@mutex.synchronize {
  #      if (@@finished_pages[url_finally] or @@planned_pages[url_finally])
  #        @@planned_pages << url_finally
  #      end
  #    }
  #  end
  #end
end
