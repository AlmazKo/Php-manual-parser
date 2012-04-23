# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'dbl/mysql'
require 'digest/md5'

class Index
  MYSQL = DblMysql.new

  def initialize
    clean_tables
    fill_tables
  end

  def download_page anchor, html
       hasPage  html
  end

  # @param [Html] html_page
  def hasPage html_page
    sql = 'SELECT id from page_mem where name = ? and content_hash = ?'
    MYSQL.query sql, [html_page.name, Digest::MD5.new(html_page.content)]
  end
  
  def parsing_page

  end

  def get_anchors
      sql = 'SELECT * FROM `anchor` where to_page_id IS NOT NULL'
      []
  end

  private

  def clean_tables
    MYSQL.query 'TRUNCATE `anchor_mem`'
    MYSQL.query 'TRUNCATE `page_mem`'
  end

  def fill_tables
    MYSQL.query 'INSERT INTO `page_mem` (id, parent_id, name, url, date, content_hash, completely) '\
                'SELECT id, parent_id, name, url, date, md5(content), completely from `page`'
    MYSQL.query 'INSERT INTO `anchor_mem` SELECT * from `anchor_mem`'
  end
end