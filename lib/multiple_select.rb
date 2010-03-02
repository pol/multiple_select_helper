require 'fight_the_melons/helpers/form_multiple_select_helper'

module ActionView #:nodoc:
  module Helpers #:nodoc:
    class InstanceTag #:nodoc:
      include FightTheMelons::Helpers::FormMultipleSelectHelper
      include FightTheMelons::Helpers
      
      def to_multiple_select_tag(name, container, options)
        multiple_select_with_path(name, options) do |selected_items|
          checkboxes_for_multiple_select(
            name, container, selected_items, options
          )
        end
      end
      
      def to_collection_multiple_select_tag(name, collection, value_method, text_method, options)
        multiple_select_with_path(name, options) do |selected_items|
          checkboxes_from_collection_for_multiple_select(
            name, collection, value_method, text_method, selected_items, options
          )
        end
      end
      
      def to_tree_multiple_select_tag(name, nodes, value_method, text_method, options)
        multiple_select_with_path(name, options) do |selected_items|
          checkboxes_from_tree_for_multiple_select(
            name, nodes, value_method, text_method, selected_items, options
          )
        end
      end
    end
  end
end

ActionView::Base.send(:include, FightTheMelons::Helpers::FormMultipleSelectHelper)