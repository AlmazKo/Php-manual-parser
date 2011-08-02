# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'mysql'

class DblMysql
    
    INSERT = 1
    @@mutex = Mutex.new
    
    def initialize
      @my = Mysql::real_connect('localhost', 'root', '210411', 'php_manual')
    end

    def query sql, values, type = nil
      stmt = @my.prepare(sql)
      @@mutex.synchronize do
        begin
          stmt.execute(*values)
        rescue => ex
          puts ex
          return nil
        end
        
        case type
        when INSERT
          return stmt.insert_id()
        end
      end

      stmt
    end
    
  end

