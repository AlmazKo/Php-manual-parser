# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'parser'
class ParsingManager
  def initialize queue_from, queue_to
    @queue_from, @queue_to = queue_from, queue_to
    group = ThreadGroup.new
    Thread.new(@queue_from) { |queue|
      while true
        if (group.list.size < @@available_workers)
          result = queue_from.deq
          group.add(
            Thread.new(queue_to, result[:url], result[:html]) {|queue, url, html| 
              parser = Parser.new(html, url, queue)
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
