module PhpManualParser

  class DblMysql

    LOG_ID = :mysql
    INSERT_SQL = 'INSERT INTO `%s` (%s) VALUES (%s)'

    @@mutex = Mutex.new

    def initialize
      @my = Mysql::real_connect('localhost', 'root', '210411', 'php_manual')
    end

    # @return [Integer]
    def insert(table_name, list_columns, list_values)
      str_queries = (['?'] * list_values.size).join(',')
      sql = INSERT_SQL % [table_name, list_columns.join(','), str_queries]

      message = INSERT_SQL % [table_name, list_columns.join(','), values_to_s(list_values)]
      Log::add message, LOG_ID

      query :insert, sql, list_values
    end

    # @param [Symbol] type 
    # @param [String] sql
    # @param [Enumerable] values
    def query(type, sql, values = [])

      stmt = @my.prepare(sql)

      @@mutex.synchronize do
        begin
          stmt.execute(*values)
        rescue => ex
          Log::add ex, LOG_ID
          return nil
        end

        case type
          when :insert
            return stmt.insert_id()
        end
      end

      stmt
    end


    private

    # @param [Enumerable] values
    # @return [String]
    def values_to_s(values = [], type = nil)

      list_short_values = values.inject([]) do |list, value|
        list << case value
                  when NilClass then
                    'NULL'
                  when Numeric
                    value.to_s
                  else
                    str_value = value.to_s

                    if str_value.size > 40
                      str_value = str_value[0, 39] + '...'
                    end

                    '"' + str_value + '"'
                end
      end

      list_short_values.join(', ')
    end
  end
end
