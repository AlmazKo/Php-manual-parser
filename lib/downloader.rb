# To change this template, choose Tools | Templates
# and open the template in the editor.

class Downloader
  
  @@php_net = PhpNet.new
  
  def initialize url, queue
    request = @@php_net.get_request(url)
    uri = URI.parse url
    
    result = HTTP.start(uri.host, uri.port) {|http|
      http.request(request)
    }
    
    queue.enq result
    nil
  end
end
