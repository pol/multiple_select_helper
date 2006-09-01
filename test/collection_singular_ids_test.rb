require File.dirname(__FILE__) + '/test_helper'

class CollectionSingularIdsTest < Test::Unit::TestCase #:nodoc:
  
  fixtures :fathers, :sons, :toys, :fathers_sons
  
  def test_has_many_without_through
    Father.class_eval 'has_many :sons'
    Son.class_eval 'belongs_to :father'
    
    f = fathers(:without_sons)
    assert f.respond_to?(:son_ids)
    assert_equal [], f.son_ids
    
    f = fathers(:with_sons)
    assert_equal [1, 2, 3], f.son_ids
  end
  
  def test_has_many_with_through
    Father.class_eval do
      has_many :sons
      has_many :toys, :through => :sons
    end
    Son.class_eval do
      has_many :toys
      belongs_to :father
    end
    
    f = fathers(:with_toys)
    assert !f.respond_to?(:toy_ids)
  end
  
  def test_has_and_belongs_to_many
    Father.class_eval 'has_and_belongs_to_many :sons'
    Son.class_eval 'has_and_belongs_to_many :fathers'
    
    f = fathers(:without_habtm_sons)
    assert f.respond_to?(:son_ids)
    assert_equal [], f.son_ids
    
    f = fathers(:with_habtm_sons)
    assert_equal [4, 5, 6], f.son_ids
  end
end
