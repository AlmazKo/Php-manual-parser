# To change this template, choose Tools | Templates
# and open the template in the editor.

class Storage
  def initialize
    @my = Mysql::real_connect('localhost', 'root', '210411', 'php_manual')
  end
  
  # Добавить модель в базу и прописать ей id
  #  
  def add! (model)
    vars = model.instance_variables
    cols = []
    values = []
    vars.each {|item|
      cols << item[1..-1]
      values << model.instance_variable_get(item)
    }
    
    tbl = model.class.to_s.downcase
    begin
      stmt = @my.prepare("INSERT INTO #{tbl} (#{cols.join(',')}) VALUES (#{(['?'] * values.size).join(',')})")
      stmt.execute(*values)
      model.id = stmt.insert_id()
      model
    rescue => ex
      puts ex
      nil
    end
  end
end
