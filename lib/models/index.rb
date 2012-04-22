#
#

class Index
  MYSQL = DblMysql.new

  def initialize
    clean_tables
    fill_tables
  end


  def get_urs
      sql = 'SELECT '
  end

  private

  def clean_tables
    MYSQL.query 'TRUNCATE `page_mem`'
  end

  def fill_tables
    MYSQL.query 'INSERT INTO `page_mem` (id, parent_id, name, url, date, completely) '\
                'SELECT id, parent_id, name, url, date, completely from `page`'
  end
end