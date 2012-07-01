# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'analyzer'

require 'entities/anchor'
require 'entities/page'
require 'entities/note'


require 'task'
require 'log'


module PhpManualParser


  class Main
    Log::draw
    Thread.current[:name] = :main

    def self.join_all
      main = Thread.main
      current = Thread.current
      all = Thread.list
      all.each { |t| t.join unless t == current or t == main }
    end
#
#def puts str
#  $scroll.add str.to_s + '--'
#end
    def self.start
      Thread.abort_on_exception = true

      time_begin = Time.now
      join_all()

      anchor = Anchor.new
      anchor.url = Analyzer::MANUAL_URL
      anchor.from_page_id = 0

      analyzer = Analyzer.new
      analyzer.add_anchor anchor
      analyzer.start



      Log::add "Total time: %01.3f sec" % (Time.now - time_begin)
    end

  end
#php_net.set_cookies(result.response['set-cookie'])

#def parsing result


#html.css('body a').each do |link|


#      request = php_net.get_request(url_finally)
#
#      result = HTTP.start(url.host, url.port) {|http|
#        http.request(request)
#      }
#
#      page = Page.new
#      page.url = url.to_s
#      page.name = link.content
#      page.parent_id
#      storage.add!(page)
#      puts 'Парсинг страницы ' << url.to_s
#
#      new_html = Nokogiri::HTML(result.body)
#
#      new_html.css('#usernotes #allnotes .note').each do |notes|
#
#        notes = Note.new
#        notes.page_id = page.id
#        notes.user = notes.css('.user').to_s
#        notes.text = notes.css('.text').to_s
#        notes.link = notes.css('a').attr('href').to_s
#        notes.date = notes.css('a').content
#        Storage.add(notes)
#        exit
#      end
# puts url_finally


#end


end

