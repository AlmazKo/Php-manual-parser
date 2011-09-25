# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'dbl/mysql'

module Storage
  
  MYSQL = DblMysql.new
  
  # Добавить модель в базу и прописать ей id
  #  
  def add!

    columns = []
    values = []

    get_vars.each_pair { |index,value|
      columns << index
      values << value
    }

    table_name = self.class.to_s.downcase
    sql = "INSERT INTO #{table_name} (#{columns.join(',')}) VALUES (#{(['?'] * values.size).join(',')})"
    self.id = MYSQL.query sql, values, DblMysql::INSERT
    nil
  end
    
  def get! id
   
    columns = []
    
    get_vars.each_key { |index|
      columns << index
    }
    
    table_name = self.class.to_s.downcase
  
    sql = "SELECT #{columns.join(',')} FROM #{table_name} WHERE id= ? LIMIT 1"

    values = []
    result = MYSQL.query(sql, id)
    
    result.each { |value|
      values << value
    }
    
    result = Hash[columns.zip(values.flatten())]
    result.each_pair { |key,value|
      instance_variable_set('@'<< key, value)
    }
    puts self.inspect
    nil
  end

  
  private
  
  #     mod.get_vars(symbol)    => Hash
  def get_vars
    vars = {}
    if (self.class.method_defined? :get_model_vars)
      vars = get_model_vars()
    else
      instance_variables.each { |var| 
        vars[var.to_s.sub('@','')] = instance_variable_get(var) 
        }
    end
    vars
  end
end
