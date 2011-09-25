# coding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

class Parser
  def initialize html, url, queue

     @html = Nokogiri::HTML(html.body)
     

    html.head.css('title').each do |link|
      
    end
    page = Page.new
    page.url = url.to_s
    page.name = link.content
    page.parent_id
    page.add!(page)
    puts 'Парсинг страницы ' << url.to_s
  
    new_html = Nokogiri::HTML(result.body)

    new_html.css('#usernotes #allnotes .note').each do |notes|

      notes = Note.new
      notes.page_id = page.id
      notes.user = notes.css('.user').to_s
      notes.text = notes.css('.text').to_s
      notes.link = notes.css('a').attr('href').to_s
      notes.date = notes.css('a').content
      Storage.add(notes)
      exit

    
      puts url_finally
      @@mutex.synchronize {
        if (@@finished_pages[url_finally] or @@planned_pages[url_finally])
          @@planned_pages << url_finally
        end
      }
    end
    
     get_urls().each { |item|
       queue.enq(item)
     }
  end
  
    def get_urls
      @html.css('a').each do |link|
        urls = []
        link_href = link.attr('href')
        if (link_href[0] == '/')
          next unless link_href.start_with?('/manual/en')
          urls << (PHP_NET_URL << link_href)
        else
          # TODO сделать более гибкое условие
          next if link_href.start_with?('http://')
          urls << (PHP_NET_URL << link_href)
        end
      end
      urls
    end
    
    def get_notes
      
    end
    
    def get_context
      
    end

  
end
