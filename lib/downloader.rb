# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'php_net'

class Downloader
    
  include Net
  
  @@php_net = PhpNet.new

  # @param [Index] analyzer
  def initialize link, analyzer

    uri = URI.parse link.url
    request = @@php_net.get_request(uri)
    
    
    result = HTTP.start(uri.host, uri.port) {|http|
      http.request(request)
    }
    analyzer.download_page link, result
    nil
  end
end
