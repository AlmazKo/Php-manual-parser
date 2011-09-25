require 'downloader'

class DownloadManager
  @@available_workers = 1
  
  def initialize queue_from, queue_to
    @queue_from, @queue_to = queue_from, queue_to
    group = ThreadGroup.new
    Thread.new(@queue_from) { |queue|
      while true
        if (group.list.size < @@available_workers)
          new_url = queue_from.deq

          group.add(
            Thread.new(queue_to, new_url) {|queue, url| 

             x = Downloader.new(url, queue)

                           
             }
          )
        else
          # TODO make after with JOIN
          sleep(0.001)
#          group.list.each { |thread|  
#            
#          }
        end
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
