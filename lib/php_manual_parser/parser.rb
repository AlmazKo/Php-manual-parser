# coding: utf-8
module PhpManualParser

  class Parser

    def initialize parsed_queue, task_queue

      @parsed_queue, @task_queue = parsed_queue, task_queue

    end

    def start
      while true
        downloaded = @parsed_queue.deq
        parsing downloaded[:response], downloaded[:anchor]
      end
    end

    def parsing (response, anchor)
      Log::add 'Page parsing ' << anchor.url

      html = Nokogiri::HTML(response.body)

      page = get_page(html, anchor)

      notes = get_notes(html)
      Log::add ('Found %s notes' % notes.count)
      contents_urls = get_contents_urls(html)
      Log::add ('Found %s anchors' % contents_urls.count)

      @task_queue.enq Task.new(anchor, page, notes, contents_urls)
    end

    #TODO придумать название
    def get_contents_urls (html)
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

    def get_page html, anchor
      page = Page.new
      page.url = anchor.url.to_s
      page.name = html.title
      page.content = html.to_s
      page.date = Time.new
      page
    end

    def get_context

    end


  end
end
