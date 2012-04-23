require 'downloader'

class DownloadManager
  @@available_workers = 1

  def initialize queue_from, analyzer
    group = ThreadGroup.new
    Thread.new(@queue_from) { |queue|
      while true
          link = queue_from.deq

          group.add(
            Thread.new(analyzer, link) {|analyzer, link|
              Downloader.new(link, analyzer)
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
