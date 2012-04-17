# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'parser'
class ParsingManager
  def initialize queue_from, queue_to
    @queue_from, @queue_to = queue_from, queue_to
    group = ThreadGroup.new
    Thread.new(@queue_from) { |queue|
      while true
        result = queue_from.deq
          group.add(
            Thread.new(queue_to, result[:link], result[:html]) {|queue, link, html|
              parser = Parser.new(html, link, queue)
            }
          )

      end
    }
  end

end
