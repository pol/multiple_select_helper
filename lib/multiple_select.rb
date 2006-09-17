require 'erb'
require 'action_view'

module FightTheMelons #:nodoc:
  module Helpers #:nodoc:
    # Provides a number of methods for turning different kinds of containers
    # into checkboxes lists.
    module FormMultipleSelectHelper
      include ERB::Util
      include ActionView::Helpers::FormTagHelper
      include ActionView::Helpers::TagHelper
      
      # Some of the most used variables so you can setup them per application or
      # per controller instead of everytime you use one of the helpers.
      
      # Class used in the ul tag that wraps all the checkboxes.
      attr_accessor :outer_class
      module_function :outer_class, :outer_class=
      
      # Class used in the li tag that wraps each checkbox.
      attr_accessor :inner_class
      module_function :inner_class, :inner_class=
      
      # Prefix of the level class added to the inner class in the tree methods.
      attr_accessor :level_class
      module_function :level_class, :level_class=
      
      # Class for the alternate elements. Added to inner class.
      attr_accessor :alternate_class
      module_function :alternate_class, :alternate_class=
      
      # Determines if the methods will alternate the classes of the checkboxes.
      attr_accessor :alternate
      module_function :alternate, :alternate=
      
      # Establish the position of the checkbox with respect the label.
      attr_accessor :position
      module_function :position, :position=
      
      # Determines if a hidden field should be added to the checkboxes.
      attr_accessor :hidden_field
      module_function :hidden_field, :hidden_field=
      
      # Establish the name of the tags used to wrap the elements.
      attr_accessor :list_tags
      module_function :list_tags, :list_tags=
      
      # Default value for alternate is false.
      FightTheMelons::Helpers::FormMultipleSelectHelper.alternate = false
      
      # Default value for alternate_class is 'alt'.
      FightTheMelons::Helpers::FormMultipleSelectHelper.alternate_class = 'alt'
      
      # Default value for position is ':right'
      FightTheMelons::Helpers::FormMultipleSelectHelper.position = :right
      
      # Default value for hidden_field is false.
      FightTheMelons::Helpers::FormMultipleSelectHelper.hidden_field = false
      
      # Default value for list_tags is ['ul', 'li']
      FightTheMelons::Helpers::FormMultipleSelectHelper.list_tags = ['ul', 'li']
      
      # Returns a list of checkboxes usign
      # checkboxes_from_collection_for_multiple_select to generate the list of
      # checkboxes.
      #
      # If a <tt>:selected_items</tt> option is provided it will be used as
      # selection.
      #
      # The option <tt>:outer_class</tt> specifies the HTML class of the ul
      # element that wraps the checkbox list.
      def collection_multiple_select(
        name, collection, value_method, text_method, options = {}
      )
        multiple_select_with_path(name, options) do |selected_items|
          checkboxes_from_collection_for_multiple_select(name, collection,
            value_method, text_method, selected_items, options
          )
        end
      end
      
      # Create a list of checkboxes. See checkboxes_for_multiple_select for the
      # required format of the choices parameter.
      #
      # If a <tt>:selected_items</tt> option is provided it will be used as
      # selection.
      #
      # The option <tt>:outer_class</tt> specifies the HTML class of the ul
      # element that wraps the checkbox list.
      def multiple_select(name, container, options = {})
        multiple_select_with_path(name, options) do |selected_items|
          checkboxes_for_multiple_select(
            name, container, selected_items, options
          )
        end
      end
      
      # Create a list of hierarchical checkboxes using
      # checkboxes_from_tree_for_multiple_select. The hierarchy must respond to
      # <tt>:child_method</tt> option to get the direct children of the actual
      # node. The default value is <tt>children</tt>.
      #
      # If a <tt>:selected_items</tt> option is provided it will be used as
      # selection.
      #
      # The option <tt>:outer_class</tt> specifies the HTML class of the ul
      # element that wraps the checkbox hierarchy.
      def tree_multiple_select(
        name, nodes, value_method, text_method, options = {}
      )
        multiple_select_with_path(name, options) do |selected_items|
          checkboxes_from_tree_for_multiple_select(
            name, nodes, value_method, text_method, selected_items, options
          )
        end
      end
      
      # Returns a string of checkboxes that have been compiled iterating over
      # the <tt>collection</tt> and assigning the result of a call to the
      # <tt>value_method</tt> as the option value and the <tt>text_method</tt>
      # as the label text. If <tt>selected_items</tt> is specified, the element
      # returning a match on <tt>value_method</tt> will get the selected
      # attribute in its checkbox. See checkboxes_for_multiple_select for the
      # allowed options in the hash.
      def checkboxes_from_collection_for_multiple_select(
        name, collection, value_method, text_method, selected_items = [],
        options = {}
      )
        coll = (collection or [])
        
        checkboxes_for_multiple_select(
          name,
          coll.map { |item| [item.send(text_method), item.send(value_method)] },
          selected_items, options
        )
      end
      
      # Returns a string of checkboxes that have been compiling descending the
      # <tt>node</tt> and assigning the result of a call to the
      # <tt>value_method</tt> as the option value and the <tt>text_method</tt>
      # as the label text. If <tt>selected_items</tt> is specified, the element
      # returning a match on <tt>value_method</tt> will get the selected
      # attribute in its checkbox.
      #
      # The option <tt>:depth</tt> specifies the maximum depth of the nodes to
      # show. It defaults to infinity.
      #
      # The option <tt>:level_class</tt> is a CSS class prefix that will be
      # applied to the checkbox li element suffixing it with the actual depth.
      #
      # The option <tt>:initial_level</tt> is the value that will be used as suffix
      # for <tt>level_class</tt> option. It defaults to 0.
      #
      # The option <tt>:child_method</tt> allows access to an array of direct
      # children of the actual method. It defaults to "children".
      # 
      # See checkboxes_for_multiple_select for more allowed options.
      def checkboxes_from_tree_for_multiple_select(
        name, nodes, value_method, text_method, selected_items = [],
        options = {}
      )
        depth = (options[:depth] or -1)
        ilevel_class = (options[:level_class] or
          FightTheMelons::Helpers::FormMultipleSelectHelper.level_class)
        initial_level = (options[:initial_level] or 0)
        child_method = (options[:child_method] or :children)
        iinner_class = (options[:inner_class] or
          FightTheMelons::Helpers::FormMultipleSelectHelper.inner_class)
        ialternate = options[:alternate].nil? ?
          FightTheMelons::Helpers::FormMultipleSelectHelper.alternate :
          options[:alternate]
        alt = (options[:initial_alternate] or false) if ialternate
        
        root_options = options.dup
        if ilevel_class
          root_options[:inner_class] =
            "#{iinner_class} #{ilevel_class}#{initial_level}".strip
        end
        root_options[:initial_alternate] = alt if ialternate
        
        child_options = {
          :depth => depth - 1,
          :initial_level => initial_level + 1,
          :inner_class => iinner_class,
        }
        child_options = options.merge(child_options)
        child_options[:initial_alternate] = !alt if ialternate
        
        checkboxes = nodes.map do |node|
          parent = checkbox_for_multiple_select(
            name,
            [node.send(text_method), node.send(value_method)],
            selected_items, alt, root_options
          ) do
            
            children = node.send(child_method)
            branch = if not (depth == 0 || children.size == 0)
	            "\n" + content_tag(
	              FightTheMelons::Helpers::FormMultipleSelectHelper.list_tags[0],
	              checkboxes_from_tree_for_multiple_select(
                    name, children, value_method, text_method, selected_items,
                    child_options
                  )
                )
              else
                ''
              end
            
            if ialternate
              alt = alt ? (not children.size%2 == 0) : (children.size%2 == 0)
              root_options[:initial_alternate] = alt
              child_options[:initial_alternate] = !alt
            end
            
            branch
          end
        end
        
        checkboxes.join("\n")
      end
      
      # Accepts a container (hash, array, enumerable, your type) and returns a
      # string of checkbox tags. Given a container where the elements respond to
      # first and last (such a two-element array), the "last" serve as checkbox
      # values and the "first" as label text. Hashes are turned into this form
      # automatically, so the keys beceome "first" and the values become
      # "lasts". If <tt>selected_items</tt> is not empty, the matching
      # elements will get the selected attribute in its checkbox. If the option
      # <tt>:label_position</tt> is provided the specified position is used
      # (<tt>:left</tt> or <tt>:right</tt>), otherwise the default
      # <tt>:right</tt> position is used.
      #
      # The <tt>:inner_class</tt> option specifies the base class of the li
      # that surrounds the checkbox and the label.
      #
      # The <tt>:alternate_class</tt> option allow to specify
      # a additional class that will be used in odd elements if
      # <tt>:alternate</tt> is <tt>true</tt>.
      #
      # The <tt>:initial_alternate</tt> option specifies if the first element
      # should have the alternate style or not. By default the first element
      # does not have the alternate style.
      #
      # If the option <tt>:position</tt> is provided the specified
      # position is used (<tt>:left</tt> or <tt>:right</tt>), otherwise the
      # default <tt>:right</tt> position is used.
      #
      # The <tt>:inner_class</tt> option specifies the base class of the div that
      # surrounds the checkbox and the label.
      #
      # The <tt>:disabled</tt> option specifies if the checkbox will be rendered
      # disabled or not. Disabled can be <tt>true</tt>, <tt>false</tt> or an
      # array of values that will be disabled. By default the checkbox will not
      # be disabled.
      def checkboxes_for_multiple_select(name, container, selected_items = [],
        options = {}
      )
        container = container.to_a if Hash === container
        ialternate = options[:alternate].nil? ?
          FightTheMelons::Helpers::FormMultipleSelectHelper.alternate :
          options[:alternate]
        alt = (options[:initial_alternate] or false)
        
        checkboxes = container.map do |item|
          cbfms = checkbox_for_multiple_select(
            name, item, selected_items, alt, options
          )
          alt = !alt if ialternate
          cbfms
        end
        
        checkboxes.join("\n")
      end
    
    private
      
      # Common body for multiple_select, collection_multiple_select and
      # tree_multiple_select.
      def multiple_select_with_path(name, options, &block)
        selected_items = (options[:selected_items] or [])
        iouter_class = (options[:outer_class] or
          FightTheMelons::Helpers::FormMultipleSelectHelper.outer_class)
        ihidden_field = options[:hidden_field].nil? ?
          FightTheMelons::Helpers::FormMultipleSelectHelper.hidden_field :
          options[:hidden_field]
        
        checkboxes = yield(selected_items)
        if ihidden_field
          checkboxes += hidden_field_tag("#{name}[]", '', :id => nil)
        end
        
        content_tag(
          FightTheMelons::Helpers::FormMultipleSelectHelper.list_tags[0],
          checkboxes, :class => iouter_class
        )
      end
      
      # Accepts an item and returns a checkbox tag. If the item respond to first
      # and last (such a two element array), the "last" serve as checkbox value
      # and the "first" as label text. If the item is included in the
      # <tt>selected_items</tt> its checkbox will be selected. The
      # <tt>is_alternate</tt> determines if the checkbox will use the alternate
      # class name or not.
      def checkbox_for_multiple_select(
        name, item, selected_items = [], is_alternate = false, options = {}
      )
        iposition = (options[:position] or
          FightTheMelons::Helpers::FormMultipleSelectHelper.position)
        iinner_class = (options[:inner_class] or
          FightTheMelons::Helpers::FormMultipleSelectHelper.inner_class)
        ialternate_class = (options[:alternate_class] or
          FightTheMelons::Helpers::FormMultipleSelectHelper.alternate_class)
        is_disabled = (options[:disabled] or false)
        
        if !item.is_a?(String) and item.respond_to?(:first) and item.respond_to?(:last)
          is_selected = selected_items.include?(item.last)
          is_disabled = is_disabled.include?(item.last) if is_disabled.respond_to?(:include?)
          item_id = idfy("#{name}#{item.last}")
          cbt = check_box_tag("#{name}[]", html_escape(item.last.to_s), is_selected, :id => item_id, :disabled => is_disabled)
          lbt = content_tag('label', html_escape(item.first.to_s), :for => item_id)
        else
          is_selected = selected_items.include?(item)
          is_disabled = is_disabled.include?(item) if is_disabled.respond_to?(:include?)
          item_id = idfy("#{name}#{item.to_s}")
          cbt = check_box_tag("#{name}[]", html_escape(item.to_s), is_selected, :id => item_id, :disabled => is_disabled)
          lbt = content_tag('label', html_escape(item.to_s), :for => item_id)
        end
        
        item_class = is_alternate ? "#{iinner_class} #{ialternate_class}".strip : iinner_class
        
        extra = block_given? ? yield : ''
        
        content_tag(
          FightTheMelons::Helpers::FormMultipleSelectHelper.list_tags[1],
          iposition == :left ? lbt + cbt + extra : cbt + lbt + extra,
          :class => item_class
        )
      end
      
      # Convert the string <tt>name</tt> provided into a HTML 4.01 valid
      # identifier. If <tt>name</tt> does not start with a letter it will be
      # prepend an 'x' character. All characters outside the posible characters
      # for a HTML identifier are replaced by an underscore ("_"). The only
      # valid characters are letters, digits, hyphens ("-"), underscores ("_"),
      # colons (":") and periods ("."). See
      # http://www.w3.org/TR/html4/types.html#type-name for more information.
      def idfy(name)
        name = 'x' + name unless /^[a-zA-Z]/ =~ name
        name.scan(/[-a-zA-Z0-9_:.]+/).join('_')
      end
    end
  end
end