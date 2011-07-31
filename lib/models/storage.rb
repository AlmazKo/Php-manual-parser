# To change this template, choose Tools | Templates
# and open the template in the editor.

module Storage
  
  MYSQL = Mysql.new
  
  # Добавить модель в базу и прописать ей id
  #  
  def add!

    columns = []
    values = []
    
    Storage.get_vars.each_with_index { |index,value|
      columns << index
      values << value
    }
    
    table_name = self.class.downcase
  
    self.id = MYSQL.query("INSERT INTO #{table_name} (#{columns.join(',')}) VALUES (#{(['?'] * values.size).join(',')})", values)
    nil
  end
    
  class Mysql
    
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
  
  private
  
  #     mod.get_vars(symbol)    => Hash
  def get_vars
    vars = {}
    if (self.class.method_defined? :get_model_vars)
      vars = get_model_vars()
    else
      instance_variables.each { |var| vars[var.to_sym] = instance_variable_get(var) }
    end
    vars
  end
end
