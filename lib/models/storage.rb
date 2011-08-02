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
    
    Storage.get_vars.each_with_index { |index,value|
      columns << index
      values << value
    }
    
    table_name = self.class.downcase
  
    sql = "INSERT INTO #{table_name} (#{columns.join(',')}) VALUES (#{(['?'] * values.size).join(',')})"
    self.id = MYSQL.query sql, values
    nil
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
