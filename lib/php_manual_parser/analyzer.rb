# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'download_manager'
require 'parser'

module PhpManualParser

  class Analyzer
    PHP_NET_URL = 'http://php.net'
    MANUAL_URL = PHP_NET_URL + '/manual/en/'
    DOWNLOADER_WORKERS = 1

    @@mutex = Mutex.new

    attr_reader :observers, :download_queue, :parsed_queue, :anchors_underway;

    def initialize
      @observers = {}
      @anchors_underway = {}
      #@download_queue = SizedQueue.new DOWNLOADER_WORKERS
      @download_queue = Queue.new

      @parsed_queue = Queue.new
      @task_queue = Queue.new
      @downloader_manager = DownloadManager.new @download_queue, @parsed_queue
      Thread.new(@parsed_queue, @task_queue) { |parsed_queue, task_queue|
        Thread.current[:name] = :parser
        Parser.new(parsed_queue, task_queue).start
      }

    end

    def add_anchor(anchor)
      @task_queue.enq(Task.new anchor)
    end

    def start
      2.times() {
        #while true
        task = @task_queue.deq
        if task.new?
          event_new_anchor task.anchor
        else
          event_parse_page task
        end

      }
    end


    protected

    def event_new_anchor anchor
      Log::add 'ADD URL: ' + anchor.url

      anchor.canonical_url, anchor.to_note_id = parse_url anchor
      anchor.url_params = ''
      Log::add 'Canonical URL: ' + anchor.canonical_url

      @@mutex.synchronize {
        if @anchors_underway[anchor.canonical_url]
          if @observers[anchor.canonical_url]
            @observers[anchor.canonical_url] << anchor
          else
            @observers[anchor.canonical_url] = [anchor]
          end
        else
          @anchors_underway[anchor.canonical_url] = anchor
          #if @storage.find_anchor! anchor
          #  anchor.add!
          #end
          @download_queue.enq anchor
        end
      }
    end

    # @param [PhpManualParser::Task] task
    def event_parse_page(task)

      anchor = task.anchor

      Log::add 'PROCESSING URL: ' + anchor.canonical_url

      @@mutex.synchronize {

        if @observers[anchor.canonical_url]
          @observers[anchor.canonical_url].each { |observer_anchor|
            observer_anchor.dst_page_id = anchor.dst_page_id
            observer_anchor.add!
          }

          @observers[anchor.canonical_url] = nil
        end

        Repository::add! task.page
        anchor.to_page_id = task.page.id

        Repository::add! anchor
        @anchors_underway[anchor.canonical_url] = nil

      }
    end

    # TODO realize!
    def parse_url anchor
      [anchor.url, 1]
    end

  end
end