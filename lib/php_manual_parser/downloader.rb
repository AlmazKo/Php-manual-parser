# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'php_net'
module PhpManualParser
  class Downloader

    include Net

    @@php_net = PhpNet.new

    # @param [Index] analyzer
    def initialize parser_queue, anchor

      uri = URI.parse anchor.url
      request = @@php_net.get_request(uri)


      response = HTTP.start(uri.host, uri.port) { |http|
        http.request(request)
      }

      Log::add 'DOWNLOAD: ' + anchor.url
      parser_queue.enq({anchor: anchor, response: response})
      nil
    end
  end
end