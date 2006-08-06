class Node < ActiveRecord::Base #:nodoc:
  acts_as_tree
  
  def alt_children
  	self.children
  end
end
