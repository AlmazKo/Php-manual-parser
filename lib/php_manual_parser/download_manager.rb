require 'downloader'

module PhpManualParser

  class DownloadManager
    @@available_workers = 1

    def initialize anchor_queue, parser_queue
      group = ThreadGroup.new
      Thread.new(anchor_queue) { |anchor_queue|
        Thread.current[:name] = :downloader
        while true
          anchor = anchor_queue.deq
          group.add(
              Thread.new(parser_queue, anchor) { |parser_queue, anchor|
                Thread.current[:name] = :downloader
                Downloader.new(parser_queue, anchor)
              }
          )
        end
      }
    end


    class << self
      def workers= number
        @@available_workers = number
        self
      end
    end

  end
end