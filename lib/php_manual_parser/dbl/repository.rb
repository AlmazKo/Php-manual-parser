module PhpManualParser
  class Repository

    MYSQL = DblMysql.new

    @entity_fields = {}
    #@@mutex = Mutex.new
    #@@mysql = DblMysql.new

    @@list_queries = {}

    #todo not use!
    def add(object)
      object.freeze
      @@list_queries[object.class] << object
      nil
    end

    # @param [Entity] entity
    def self.add!(entity)
      table_name = entity.get_table_name
      values = entity.get_properties_values
      list_columns = get_entity_fields(entity)

      id = MYSQL.insert table_name, list_columns, values

      Log::add table_name + ' new id: ' + id.to_s

      entity.pk_value = id if list_columns.include? 'id'
      entity.freeze
      entity
    end


    # @param [Entity] entity
    def self.get_entity_fields(entity)
      unless @entity_fields[entity.class]
        @entity_fields[entity.class] = entity.get_properties_names
      end

      return @entity_fields[entity.class]
    end

    def get

    end

    def force

      @@list_queries.each { |list_objects|
        unless list_objects.empty?
          query = "INSERT INTO #{table_name} (#{columns.join(',')}) VALUES "
          list_objects.each {

          }
        end

      }
    end

  end
end