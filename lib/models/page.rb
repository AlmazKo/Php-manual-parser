# To change this template, choose Tools | Templates
# and open the template in the editor.

class Page
  
  include Storage
  
  attr_accessor :id, :parent_id, :name, :url, :date

  def initialize
    @id, @parent_id, @name, @url, @date = nil
  end
end