# To change this template, choose Tools | Templates
# and open the template in the editor.

class Page < Model
  
  include Storage
  
  attr_accessor :id, :parent_id, :name, :url, :date_add, :date_upd

end