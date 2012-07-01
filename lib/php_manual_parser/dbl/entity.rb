module PhpManualParser
  class Entity
    @@args = {}


    def self.attr_accessor(*args)
      super *args
      args.each { |var|
        var = ('@' + var.to_s).to_sym
        if @@args[self]
          @@args[self] << var
        else
          @@args[self] = [var]
        end
      }
      nil
    end


    def pk_value= value
      @id = value
    end

    def get_table_name
      self.class.to_s.split('::').pop.downcase
    end

    def initialize
      @@args[self.class].each { |var|
        instance_variable_set(var, nil)
      }
    end

    # @return [Array]
    def get_properties_names
      name_vars = []
      instance_variables.each { |var|
        name_vars << var.to_s.sub!('@', '')
      }
      name_vars
    end

    # @return [Array]
    def get_properties_values
      values = []
      instance_variables.each { |var|
        values << instance_variable_get(var)
      }
      values
    end

  end
end