require 'net/http'

module PhpManualParser


  class PhpNet
    include Net
    attr_reader :php_cookies
    @options
    @cookies


    def initialize (options = [])
      @options = options
    end

    def set_cookies (cookies)
      return nil unless cookies;
      @cookies = {}
      php_cookies = {}

      cookies.split(/;\s?/).each { |item|
        key, value = item.split('=', 2)

        if ('domain' == key and value =~ /COUNTRY=(.+)/)
          php_cookies['COUNTRY'] = $1
        end
        @cookies[key] = value
      }

      if (@cookies['LAST_LANG'])
        php_cookies['LAST_LANG'] = @cookies['LAST_LANG']
      end


      result = ''
      php_cookies.each_pair { |key, value| result << key << '=' << URI::encode_www_form_component(value) << '; ' }

      @php_cookies = result

    end

    def get_request (uri, cookies = nil)
      request = HTTP::Get.new(uri.path)
      request.add_field("Accept", 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8')
      request.add_field("Accept-Charset", "windows-1251,utf-8;q=0.7,*;q=0.3")
      request.add_field("User-Agent", "Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Ubuntu/11.04 Chromium/12.0.742.91 Chrome/12.0.742.91 Safari/534.30")
      request.add_field("Referer", "http://www.php.net/manual/en/")
      if (cookies == nil and @php_cookies)
        cookies = @php_cookies
      end
      request.add_field("Cookie", cookies) if cookies;

      request
    end
  end
end