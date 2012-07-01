# coding: utf-8
$:.unshift(File.dirname(__FILE__))

gem "nokogiri"
gem "mysql"
gem "bash-visual"
#gem 'test-unit'
#gem 'mocha'
require 'nokogiri'
require 'mysql'
require 'bash-visual'


require 'php_manual_parser/log'
require 'php_manual_parser/dbl/mysql'
require 'php_manual_parser/dbl/repository'
require 'php_manual_parser/dbl/entity'
require 'php_manual_parser/main'

module PhpManualParser
  VERSION = '0.1.0'

  def self.version
    VERSION
  end


 end

PhpManualParser::Main::start