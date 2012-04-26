# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'nokogiri'


require 'php_bot'
require 'models/storage'
require 'models/page'
require 'models/note'
require 'models/anchor'
require 'models/index'


require 'bash-visual'

include Bash_Visual;

font = Font.new(Font::STD, Font::LIGHT_GREEN)
console = Console.new(font)
console.clear

console.position = [0, 0]

console.draw_window(1, 11, 82, 22, 'Logs', font, Console::BORDER_UTF_DOUBLE)

$scroll = VerticalScroll.new(
    coordinates: [1, 11],
    window_size: [80, 20],
    font: font,
    start: Scroll::ENDING,
    adapt_size_message: true,
    prefix: ->{ Time.now.strftime('%H-%M-%S:%3N') << " " }
)



def puts str
  $scroll.add str
  sleep(0.8)
end

Thread.abort_on_exception = true

Time_begin = Time.now

link = Anchor.new
link.id = 1
link.url = PhpBot::MANUAL_URL

PhpBot.new.start link


def join_all
  main = Thread.main
  current = Thread.current
  all = Thread.list
  all.each {|t| t.join unless t == current or t == main}
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


  puts "\nWork #{Time.now - Time_begin} sec"
 
sleep(10)
#join_all()