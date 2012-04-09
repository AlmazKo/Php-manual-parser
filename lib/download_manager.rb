require 'downloader'

class DownloadManager
  @@available_workers = 1

  def initialize queue_from, queue_to
    group = ThreadGroup.new
    Thread.new(@queue_from) { |queue|
      while true
          link = queue_from.deq

          group.add(
            Thread.new(queue_to, link) {|queue, link|
              Downloader.new(link, queue)
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
