# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'php_net'

class Downloader
    
  include Net
  
  @@php_net = PhpNet.new
  
  def initialize url, queue

    uri = URI.parse url
    request = @@php_net.get_request(uri)
    
    
    result = HTTP.start(uri.host, uri.port) {|http|
      http.request(request)
    }
    
    queue.enq ({url: url, html: result})
    nil
  end
end
