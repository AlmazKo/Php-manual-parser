# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'php_net'

class Downloader
    
  include Net
  
  @@php_net = PhpNet.new
  
  def initialize link, queue

    uri = URI.parse link.url
    request = @@php_net.get_request(uri)
    
    
    result = HTTP.start(uri.host, uri.port) {|http|
      http.request(request)
    }
    queue.enq ({link: link, html: result})
    nil
  end
end
