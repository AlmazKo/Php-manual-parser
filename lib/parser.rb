# coding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'nokogiri'

class Parser

  def initialize response, link, queue
    puts 'Page parsing ' << link.url

    html = Nokogiri::HTML(response.body)

    page = get_page(html, link)
    page.add!

    get_notes(html).each do |note|

    end

    get_docs_urls(html).each { |url|
      puts link.url + url + "\n\n"
      #queue.enq(item)
    }
    exit
  end

  def get_docs_urls html
    urls = []
    html.css('.chunklist_set a').each do |anchor|
      href = anchor.attr('href')
      urls << href if suitable?(href)
    end
    urls
  end

  def suitable? href
    if (href =~ /https?:\/\// || href == '/')
      return false
    end
    true
  end

  def get_notes html
    notes = []
    html.css('#usernotes #allnotes .note').each do |notes|

      note = Note.new
      note.page_id = page.id
      note.user = notes.css('.user').to_s
      note.text = notes.css('.text').to_s
      note.link = notes.css('a').attr('href').to_s
      note.date = notes.css('a').content
      notes << note
    end

    notes
  end

  def get_page html, link
    page = Page.new
    page.url = link.url.to_s
    page.name = html.title
    page.parent_id
    page.date = Time.new
    #page.add!(page)
    page
  end

  def get_context

  end


end
