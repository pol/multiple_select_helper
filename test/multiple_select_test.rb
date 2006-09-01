require File.dirname(__FILE__) + '/test_helper'

class MultipleSelectTest < Test::Unit::TestCase #:nodoc:
  include FightTheMelons::Helpers::FormMultipleSelectHelper
  
  fixtures :nodes
  
  def test_cfms_empty
    assert_equal "", checkboxes_for_multiple_select('name', [])
  end
  
  def test_cfms_one_item
    assert_dom_equal "<div>" +
      "<input id=\"nametest\" name=\"name[]\" type=\"checkbox\" value=\"test\" />" +
      "<label for=\"nametest\">test</label></div>",
      checkboxes_for_multiple_select('name', ['test'])
  end
  
  def test_cfms_two_items
    assert_dom_equal "<div>" +
      "<input id=\"nametest1\" name=\"name[]\" type=\"checkbox\" value=\"test1\" />" +
      "<label for=\"nametest1\">test1</label></div>\n" +
      "<div>" +
      "<input id=\"nametest2\" name=\"name[]\" type=\"checkbox\" value=\"test2\" />" +
      "<label for=\"nametest2\">test2</label></div>",
      checkboxes_for_multiple_select('name', ['test1', 'test2'])
  end
  
  def test_cfms_array_not_strings
    assert_dom_equal "<div>" +
      "<input id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">1</label></div>\n" +
      "<div>" +
      "<input id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">2</label></div>",
      checkboxes_for_multiple_select('name', [1, 2])
  end
  
  def test_cfms_text_value_array
    assert_dom_equal "<div>" +
      "<input id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">first test</label></div>\n" +
      "<div>" +
      "<input id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">second test</label></div>",
      checkboxes_for_multiple_select('name', [['first test', 1], ['second test', 2]])
  end
  
  def test_cfms_hash
    assert_dom_equal "<div>" +
      "<input id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">second test</label></div>\n" +
      "<div>" +
      "<input id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">first test</label></div>",
      checkboxes_for_multiple_select('name', {'first test' => 1, 'second test' => 2})
  end
  
  def test_cfms_array_with_selected
    assert_dom_equal "<div>" +
      "<input checked=\"checked\" id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">1</label></div>\n" +
      "<div>" +
      "<input id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">2</label></div>",
      checkboxes_for_multiple_select('name', [1, 2], [1])
    assert_dom_equal "<div>" +
      "<input id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">1</label></div>\n" +
      "<div>" +
      "<input checked=\"checked\" id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">2</label></div>",
      checkboxes_for_multiple_select('name', [1, 2], [2])
    assert_dom_equal "<div>" +
      "<input checked=\"checked\" id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">1</label></div>\n" +
      "<div>" +
      "<input checked=\"checked\" id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">2</label></div>",
      checkboxes_for_multiple_select('name', [1, 2], [1,2])
  end
  
  def test_cfms_text_value_array_with_selected
    assert_dom_equal "<div>" +
      "<input checked=\"checked\" id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">first test</label></div>\n" +
      "<div>" +
      "<input id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">second test</label></div>",
      checkboxes_for_multiple_select('name', [['first test', 1], ['second test', 2]], [1])
    assert_dom_equal "<div>" +
      "<input id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">first test</label></div>\n" +
      "<div>" +
      "<input checked=\"checked\" id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">second test</label></div>",
      checkboxes_for_multiple_select('name', [['first test', 1], ['second test', 2]], [2])
    assert_dom_equal "<div>" +
      "<input checked=\"checked\" id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">first test</label></div>\n" +
      "<div>" +
      "<input checked=\"checked\" id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">second test</label></div>",
      checkboxes_for_multiple_select('name', [['first test', 1], ['second test', 2]], [1,2])
  end
  
  def test_cfms_hash_with_selected
    assert_dom_equal "<div>" +
      "<input checked=\"checked\" id=\"nameesp\" name=\"name[]\" type=\"checkbox\" value=\"esp\" />" +
      "<label for=\"nameesp\">Spain</label></div>\n" +
      "<div>" +
      "<input id=\"nameeng\" name=\"name[]\" type=\"checkbox\" value=\"eng\" />" +
      "<label for=\"nameeng\">England</label></div>",
      checkboxes_for_multiple_select('name', { 'Spain' => 'esp', 'England' => 'eng' }, ['esp'])
    assert_dom_equal "<div>" +
      "<input id=\"nameesp\" name=\"name[]\" type=\"checkbox\" value=\"esp\" />" +
      "<label for=\"nameesp\">Spain</label></div>\n" +
      "<div>" +
      "<input checked=\"checked\" id=\"nameeng\" name=\"name[]\" type=\"checkbox\" value=\"eng\" />" +
      "<label for=\"nameeng\">England</label></div>",
      checkboxes_for_multiple_select('name', { 'Spain' => 'esp', 'England' => 'eng' }, ['eng'])
    assert_dom_equal "<div>" +
      "<input checked=\"checked\" id=\"nameesp\" name=\"name[]\" type=\"checkbox\" value=\"esp\" />" +
      "<label for=\"nameesp\">Spain</label></div>\n" +
      "<div>" +
      "<input checked=\"checked\" id=\"nameeng\" name=\"name[]\" type=\"checkbox\" value=\"eng\" />" +
      "<label for=\"nameeng\">England</label></div>",
      checkboxes_for_multiple_select('name', { 'Spain' => 'esp', 'England' => 'eng' }, ['esp', 'eng'])
  end
  
  def test_cfms_position
    assert_dom_equal "<div>" +
      "<input id=\"nametest\" name=\"name[]\" type=\"checkbox\" value=\"test\" />" +
      "<label for=\"nametest\">test</label></div>",
      checkboxes_for_multiple_select('name', ['test'], [], :position => :right)
    assert_dom_equal "<div>" +
      "<label for=\"nametest\">test</label>" +
      "<input id=\"nametest\" name=\"name[]\" type=\"checkbox\" value=\"test\" /></div>",
      checkboxes_for_multiple_select('name', ['test'], [], :position => :left)
  end
  
  def test_cfms_inner_class
    assert_dom_equal "<div class=\"testclass\">" +
      "<input id=\"nametest\" name=\"name[]\" type=\"checkbox\" value=\"test\" />" +
      "<label for=\"nametest\">test</label></div>",
      checkboxes_for_multiple_select('name', ['test'], [], :inner_class => 'testclass')
  end
  
  def test_cfms_alternate
    assert_dom_equal "<div>" +
      "<input id=\"nametest1\" name=\"name[]\" type=\"checkbox\" value=\"test1\" />" +
      "<label for=\"nametest1\">test1</label></div>\n" +
      "<div class=\"alt\">" +
      "<input id=\"nametest2\" name=\"name[]\" type=\"checkbox\" value=\"test2\" />" +
      "<label for=\"nametest2\">test2</label></div>",
      checkboxes_for_multiple_select('name', ['test1', 'test2'], [], :alternate => true)
    assert_dom_equal "<div class=\"testclass\">" +
      "<input id=\"nametest1\" name=\"name[]\" type=\"checkbox\" value=\"test1\" />" +
      "<label for=\"nametest1\">test1</label></div>\n" +
      "<div class=\"testclass alt\">" +
      "<input id=\"nametest2\" name=\"name[]\" type=\"checkbox\" value=\"test2\" />" +
      "<label for=\"nametest2\">test2</label></div>",
      checkboxes_for_multiple_select('name', ['test1', 'test2'], [], :alternate => true, :inner_class => 'testclass')
    assert_dom_equal "<div>" +
      "<input id=\"nametest1\" name=\"name[]\" type=\"checkbox\" value=\"test1\" />" +
      "<label for=\"nametest1\">test1</label></div>\n" +
      "<div class=\"alternative\">" +
      "<input id=\"nametest2\" name=\"name[]\" type=\"checkbox\" value=\"test2\" />" +
      "<label for=\"nametest2\">test2</label></div>",
      checkboxes_for_multiple_select('name', ['test1', 'test2'], [], :alternate => true, :alternate_class => 'alternative')
    assert_dom_equal "<div>" +
      "<input id=\"nametest1\" name=\"name[]\" type=\"checkbox\" value=\"test1\" />" +
      "<label for=\"nametest1\">test1</label></div>\n" +
      "<div class=\"alt\">" +
      "<input id=\"nametest2\" name=\"name[]\" type=\"checkbox\" value=\"test2\" />" +
      "<label for=\"nametest2\">test2</label></div>",
      checkboxes_for_multiple_select('name', ['test1', 'test2'], [], :alternate => true, :initial_alternate => false)
    assert_dom_equal "<div class=\"alt\">" +
      "<input id=\"nametest1\" name=\"name[]\" type=\"checkbox\" value=\"test1\" />" +
      "<label for=\"nametest1\">test1</label></div>\n" +
      "<div>" +
      "<input id=\"nametest2\" name=\"name[]\" type=\"checkbox\" value=\"test2\" />" +
      "<label for=\"nametest2\">test2</label></div>",
      checkboxes_for_multiple_select('name', ['test1', 'test2'], [], :alternate => true, :initial_alternate => true)
  end
  
  def test_cfms_disabled
    assert_dom_equal "<div>" +
      "<input id=\"name1\" name=\"name[]\" type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">1</label></div>\n" +
      "<div>" +
      "<input id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">2</label></div>",
      checkboxes_for_multiple_select('name', [1, 2], [], :disabled => false)
    assert_dom_equal "<div>" +
      "<input disabled=\"disabled\" id=\"name1\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">1</label></div>\n" +
      "<div>" +
      "<input disabled=\"disabled\" id=\"name2\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">2</label></div>",
      checkboxes_for_multiple_select('name', [1, 2], [], :disabled => true)
    assert_dom_equal "<div>" +
      "<input disabled=\"disabled\" id=\"name1\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"1\" />" +
      "<label for=\"name1\">1</label></div>\n" +
      "<div>" +
      "<input id=\"name2\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">2</label></div>",
      checkboxes_for_multiple_select('name', [1, 2], [], :disabled => [1])
  end
  
  def test_cfcfms
    assert_dom_equal "<div>" +
      "<input id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">Node 1</label></div>\n" +
      "<div><input id=\"name3\" name=\"name[]\" type=\"checkbox\" value=\"3\" />" +
      "<label for=\"name3\">Node 2</label></div>\n" +
      "<div><input id=\"name4\" name=\"name[]\" type=\"checkbox\" value=\"4\" />" +
      "<label for=\"name4\">Node 3</label></div>",
      checkboxes_from_collection_for_multiple_select('name', Node.find_all_by_parent_id(1), :id, :name)
    assert_dom_equal "",
      checkboxes_from_collection_for_multiple_select('name', Node.find_all_by_parent_id(33), :id, :name) # id 33 doesn't exist nor have children
  end
  
  def test_cfcms_with_selected
    assert_dom_equal "<div>" +
      "<input checked=\"checked\" id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">Node 1</label></div>\n" +
      "<div><input id=\"name3\" name=\"name[]\" type=\"checkbox\" value=\"3\" />" +
      "<label for=\"name3\">Node 2</label></div>\n" +
      "<div><input checked=\"checked\" id=\"name4\" name=\"name[]\" type=\"checkbox\" value=\"4\" />" +
      "<label for=\"name4\">Node 3</label></div>",
      checkboxes_from_collection_for_multiple_select('name', Node.find_all_by_parent_id(1), :id, :name, [2, 4])
  end
  
  def test_mst
    assert_dom_equal "<div><div>" +
      "<input id=\"nametest\" name=\"name[]\" type=\"checkbox\" value=\"test\" />" +
      "<label for=\"nametest\">test</label></div>" +
      "<input name='name' type='hidden' value='' /></div>",
      multiple_select_tag('name', ['test'])
  end
  
  def test_mst_with_selected
    assert_dom_equal "<div><div>" +
      "<input checked=\"checked\" id=\"nametest1\" name=\"name[]\" type=\"checkbox\" value=\"test1\" />" +
      "<label for=\"nametest1\">test1</label></div>\n" +
      "<div>" +
      "<input id=\"nametest2\" name=\"name[]\" type=\"checkbox\" value=\"test2\" />" +
      "<label for=\"nametest2\">test2</label></div>" +
      "<input name='name' type='hidden' value='' /></div>",
      multiple_select_tag('name', ['test1', 'test2'], :selected_items => ['test1'])
  end
  
  def test_mst_outer_class
    assert_dom_equal "<div class=\"testclass\"><div>" +
      "<input id=\"nametest\" name=\"name[]\" type=\"checkbox\" value=\"test\" />" +
      "<label for=\"nametest\">test</label></div>" +
      "<input name='name' type='hidden' value='' /></div>",
      multiple_select_tag('name', ['test'], :outer_class => 'testclass')
  end
  
  def test_mst_empty_tree
    assert_dom_equal "<div>" +
      "<input name='name' type='hidden' value='' /></div>",
      multiple_select_tag('name', [])
  end

  
  def test_cmst
    assert_dom_equal "<div><div>" +
      "<input id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">Node 1</label></div>\n" +
      "<div><input id=\"name3\" name=\"name[]\" type=\"checkbox\" value=\"3\" />" +
      "<label for=\"name3\">Node 2</label></div>\n" +
      "<div><input id=\"name4\" name=\"name[]\" type=\"checkbox\" value=\"4\" />" +
      "<label for=\"name4\">Node 3</label></div>" +
      "<input name='name' type='hidden' value='' /></div>",
      collection_multiple_select_tag('name', Node.find_all_by_parent_id(1), :id, :name)
  end
  
  def test_cmst_with_selected
    assert_dom_equal "<div><div>" +
      "<input checked=\"checked\" id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">Node 1</label></div>\n" +
      "<div><input id=\"name3\" name=\"name[]\" type=\"checkbox\" value=\"3\" />" +
      "<label for=\"name3\">Node 2</label></div>\n" +
      "<div><input checked=\"checked\" id=\"name4\" name=\"name[]\" type=\"checkbox\" value=\"4\" />" +
      "<label for=\"name4\">Node 3</label></div>" +
      "<input name='name' type='hidden' value='' /></div>",
      collection_multiple_select_tag('name', Node.find_all_by_parent_id(1), :id, :name, :selected_items => [2, 4])
  end
  
  def test_cmst_outer_class
    assert_dom_equal "<div class=\"testclass\"><div>" +
      "<input id=\"name2\" name=\"name[]\" type=\"checkbox\" value=\"2\" />" +
      "<label for=\"name2\">Node 1</label></div>\n" +
      "<div><input id=\"name3\" name=\"name[]\" type=\"checkbox\" value=\"3\" />" +
      "<label for=\"name3\">Node 2</label></div>\n" +
      "<div><input id=\"name4\" name=\"name[]\" type=\"checkbox\" value=\"4\" />" +
      "<label for=\"name4\">Node 3</label></div>" +
      "<input name='name' type='hidden' value='' /></div>",
      collection_multiple_select_tag('name', Node.find_all_by_parent_id(1), :id, :name, :outer_class => 'testclass')
  end
  
  def test_cmst_empty_tree
    assert_dom_equal "<div>" +
      "<input name='name' type='hidden' value='' /></div>",
      collection_multiple_select_tag('name', nodes(:n33).children, :id, :name)
  end

  
  def test_tmst
    assert_dom_equal "<div><div>" +
      "<input id=\"name11\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div><input id=\"name12\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>" +
      "<input name='name' type='hidden' value='' /></div>",
      tree_multiple_select_tag('name', nodes(:n32).children, :id, :name)
  end
  
  def test_tmst_with_selected
    assert_dom_equal "<div><div>" +
      "<input checked=\"checked\" id=\"name11\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div><input id=\"name12\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>" +
      "<input name='name' type='hidden' value='' /></div>",
      tree_multiple_select_tag('name', nodes(:n32).children, :id, :name, :selected_items => [11])
  end
  
  def test_tmst_outer_class
    assert_dom_equal "<div class=\"testclass\"><div>" +
      "<input id=\"name11\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div><input id=\"name12\" name=\"name[]\" " +
      "type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>" +
      "<input name='name' type='hidden' value='' /></div>",
      tree_multiple_select_tag('name', nodes(:n32).children, :id, :name, :outer_class => 'testclass')
  end
  
  def test_tmst_empty_tree
    assert_dom_equal "<div>" +
      "<input name='name' type='hidden' value='' /></div>",
      tree_multiple_select_tag('name', nodes(:n33).children, :id, :name)
  end

  
  def test_ms
    assert_dom_equal "<div><div>" +
      "<input id=\"object_method_test\" name=\"object[method][]\" type=\"checkbox\" value=\"test\" />" +
      "<label for=\"object_method_test\">test</label></div>" +
      "<input name='object[method]' type='hidden' value='' /></div>",
      multiple_select('object', 'method', ['test'])
  end
  
  def test_cms
    assert_dom_equal "<div><div>" +
      "<input id=\"object_method_2\" name=\"object[method][]\" " +
      "type=\"checkbox\" value=\"2\" />" +
      "<label for=\"object_method_2\">Node 1</label></div>\n" +
      "<div><input id=\"object_method_3\" name=\"object[method][]\" " +
      "type=\"checkbox\" value=\"3\" />" +
      "<label for=\"object_method_3\">Node 2</label></div>\n" +
      "<div><input id=\"object_method_4\" name=\"object[method][]\" " +
      "type=\"checkbox\" value=\"4\" />" +
      "<label for=\"object_method_4\">Node 3</label></div>" +
      "<input name='object[method]' type='hidden' value='' /></div>",
      collection_multiple_select('object', 'method', Node.find_all_by_parent_id(1), :id, :name)
  end
  
  def test_tms
  	assert_dom_equal "<div><div>" +
      "<input id=\"object_method_11\" name=\"object[method][]\" " +
      "type=\"checkbox\" value=\"11\" />" +
      "<label for=\"object_method_11\">Node 3.2.1</label></div>\n" +
      "<div><input id=\"object_method_12\" name=\"object[method][]\" " +
      "type=\"checkbox\" value=\"12\" />" +
      "<label for=\"object_method_12\">Node 3.2.2</label></div>" +
      "<input name='object[method]' type='hidden' value='' /></div>",
      tree_multiple_select('object', 'method', nodes(:n32).children, :id, :name)
  end
    
  def test_cftfms
    assert_dom_equal "<div>" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div><input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div><input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name)
  end
  
  def test_cftfms_depth
    assert_dom_equal "<div>" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div><input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div><input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :depth => 1)
    assert_dom_equal "<div>" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div><input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div><input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :depth => 2)
    assert_dom_equal "<div>" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :depth => 0)
  end
  
  def test_cftfms_inner_class
    assert_dom_equal "<div class=\"testclass\">" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div class=\"testclass\">" +
      "<input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div class=\"testclass\">" +
      "<input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div class=\"testclass\">" +
      "<input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div class=\"testclass\">" +
      "<input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :inner_class => 'testclass')
  end
  
  def test_cftfms_level_class
    assert_dom_equal "<div class=\"level0\">" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div class=\"level0\"><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div class=\"level1\"><input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div class=\"level1\"><input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div class=\"level0\"><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :level_class => 'level')
    assert_dom_equal "<div class=\"testclass level0\">" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div class=\"testclass level0\">" +
      "<input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div class=\"testclass level1\">" +
      "<input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div class=\"testclass level1\">" +
      "<input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div class=\"testclass level0\">" +
      "<input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :level_class => 'level', :inner_class => 'testclass')
    assert_dom_equal "<div class=\"level2\">" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div class=\"level2\"><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div class=\"level3\"><input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div class=\"level3\"><input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div class=\"level2\"><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :level_class => 'level', :initial_level => 2)
  end
  
  def test_cftfms_child_method
    assert_dom_equal "<div>" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div><input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div><input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :child_method => :alt_children)
  end
  
  def test_cftfms_alternate
    assert_dom_equal "<div>" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div class=\"alt\"><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div><input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div class=\"alt\"><input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :alternate => true)
    assert_dom_equal "<div>" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div class=\"alt\"><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div><input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div class=\"alt\"><input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :alternate => true, :initial_alternate => false)
    assert_dom_equal "<div class=\"alt\">" +
      "<input id=\"name8\" name=\"name[]\" type=\"checkbox\" value=\"8\" />" +
      "<label for=\"name8\">Node 3.1</label></div>\n" +
      "<div><input id=\"name9\" name=\"name[]\" type=\"checkbox\" value=\"9\" />" +
      "<label for=\"name9\">Node 3.2</label></div>\n" +
      "<div class=\"alt\"><input id=\"name11\" name=\"name[]\" type=\"checkbox\" value=\"11\" />" +
      "<label for=\"name11\">Node 3.2.1</label></div>\n" +
      "<div><input id=\"name12\" name=\"name[]\" type=\"checkbox\" value=\"12\" />" +
      "<label for=\"name12\">Node 3.2.2</label></div>\n" +
      "<div class=\"alt\"><input id=\"name10\" name=\"name[]\" type=\"checkbox\" value=\"10\" />" +
      "<label for=\"name10\">Node 3.3</label></div>",
      checkboxes_from_tree_for_multiple_select('name', nodes(:n3).children, :id, :name, [], :alternate => true, :initial_alternate => true)
  end
end
