# To change this template, choose Tools | Templates
# and open the template in the editor.

class Note < Model
  attr_accessor :id, :user, :page_id, :text, :anchor, :date
  
  def initialize
    
  end
end