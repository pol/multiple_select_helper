class Node < ActiveRecord::Base #:nodoc:
  acts_as_tree
  
  def alt_children
  	self.children
  end
  
  def selected_none
    []
  end
  
  def selected_none=
  end
  
  def selected_some
   [12]
  end
  
  def selecte_some=
  end
end
