require 'erb'
require 'action_view'

module FightTheMelons #:nodoc:
  module Helpers #:nodoc:
    # Provides a number of methods for turning different kinds of containers
    # into a checkbox lists.
    module FormMultipleSelectHelper
      include ERB::Util
      include ActionView::Helpers::FormTagHelper
      include ActionView::Helpers::TagHelper
      
      # Returns a list of checkboxes usign
      # checkboxes_from_collection_for_multiple_select to generate the list of
      # checkboxes.
      #
      # If a <tt>:selected_items</tt> option is provided it will be used as
      # selection.
      #
      # The option <tt>:outer_class</tt> specifies the HTML class of the div
      # element that wraps the checkbox list.
      def collection_multiple_select(name, collection, value_method, text_method, options = {})
        selected_items = (options[:selected_items] || [])
        outer_class = options[:outer_class]
        
        checkboxes = checkboxes_from_collection_for_multiple_select(
          name, collection, value_method, text_method, selected_items, options
        )
        
        content_tag('div', checkboxes, :class => outer_class)
      end
      
      # Create a list of checkboxes. See checkboxes_for_multiple_select for the
      # required format of the choices parameter.
      #
      # If a <tt>:selected_items</tt> option is provided it will be used as
      # selection.
      #
      # The option <tt>:outer_class</tt> specifies the HTML class of the div
      # element that wraps the checkbox list.
      def multiple_select(name, container, options = {})
        selected_items = (options[:selected_items] || [])
        outer_class = options[:outer_class]
        
        checkboxes = checkboxes_for_multiple_select(
          name, container, selected_items, options
        )
        
        content_tag('div', checkboxes, :class => outer_class)
      end
      
      # Create a list of hierarchical checkboxes.
      # The hierarchy must respond to <tt>:child_method</tt> to get the direct
      # children of the actual node. The default value is <tt>children</tt>.
      #
      # If a <tt>:selected_items</tt> option is provided it will be used as
      # selection.
      #
      # The option <tt>:outer_class</tt> specifies the HTML class of the div
      # element that wraps the checkbox hierarchy.
      def tree_multiple_select(name, nodes, value_method, text_method, options = {})
        selected_items = (options[:selected_items] || [])
        outer_class = options[:outer_class]
        
        checkboxes = checkboxes_from_tree_for_multiple_select(
          name, nodes, value_method, text_method, selected_items, options
        )
        
        content_tag('div', checkboxes, :class => outer_class)
      end
      
      # Returns a string of checkboxes that have been compiled iterating over
      # the <tt>collection</tt> and assigning the result of a call to the
      # <tt>value_method</tt> as the option value and the <tt>text_method</tt>
      # as the label text. If <tt>selected_items</tt> is specified, the element
      # returning a match on <tt>value_method</tt> will get the selected
      # attribute in its checkbox.
      def checkboxes_from_collection_for_multiple_select(name, collection, value_method, text_method, selected_items = [], options = {})
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
      # applied to the checkbox div element suffixing it with the actual depth.
      #
      # The option <tt>initial_level</tt> is the value that will be used as suffix
      # for <tt>level_class</tt> option. It defaults to 0.
      #
      # The option <tt>child_method</tt> allows access to an array of direct
      # children of the actual method. It defaults to "children".
      def checkboxes_from_tree_for_multiple_select(name, nodes, value_method, text_method, selected_items = [], options = {})
        depth = (options[:depth] or -1)
        level_class = options[:level_class]
        initial_level = (options[:initial_level] or 0)
        child_method = (options[:child_method] or :children)
        inner_class = options[:inner_class]
        alternate = (options[:alternate] or false)
        alt = (options[:initial_alternate] or false) if alternate
        
        root_options = options.dup
        root_options[:inner_class] = "#{inner_class} #{level_class}#{initial_level}".strip if level_class
        root_options[:initial_alternate] = alt if alternate
        
        child_options = {
          :depth => depth - 1,
          :initial_level => initial_level + 1,
          :inner_class => inner_class,
        }
        child_options = options.merge(child_options)
        child_options[:initial_alternate] = !alt if alternate
        
        checkboxes_from_tree = nodes.map do |node|
          parent = checkbox_for_multiple_select(
            name,
            [node.send(text_method), node.send(value_method)],
            selected_items, alt, root_options
          )
          
          children = node.send(child_method)
          branch = if not (depth == 0 || children.size == 0)
	          parent + "\n" + checkboxes_from_tree_for_multiple_select(
                  name, children, value_method, text_method, selected_items, child_options
              )
            else
              parent
            end
          
          if alternate
            alt = alt ? (not children.size % 2 == 0) : (children.size % 2 == 0)
            root_options[:initial_alternate] = alt
            child_options[:initial_alternate] = !alt
          end
          
          branch
        end
        
        checkboxes_from_tree.join("\n")
      end
      
      # Accepts a container (hash, array, enumerable, your type) and returns a
      # string of checkbox tags. Given a container where the elements respond to
      # first and last (such a two-element array), the "last" serve as checkbox
      # values and the "first" as label text. Hashes are turned into this form
      # automatically, so the keys beceome "first" and the values become
      # "lasts". If <tt>selected_items</item> is not empty, the matching
      # elements will get the selected attribute in its checkbox. If the option
      # <tt>:label_position</tt> is provided the specified position is used
      # (<tt>:left</tt> or <tt>:right</tt>), otherwise the default
      # <tt>:right</tt> position is used.
      #
      # The <tt>:inner_class</tt> option specifies the base class of the div that
      # surrounds the checkbox and the label.
      #
      # The <tt>:alternate_class</tt> option allow to specify
      # a additional class that will be used in odd elements if
      # <tt>:alternate</tt> is <tt>true</tt>.
      #
      # The <tt>:initial_alternate</tt> option specifies if the first element
      # should have the alternate style or not. By default the first element
      # does not have the alternate style.
      def checkboxes_for_multiple_select(name, container, selected_items = [], options = {})
        container = container.to_a if Hash === container
        alternate = (options[:alternate] or false)
        alt = (options[:initial_alternate] or false)
        
        checkboxes_for_multiple_select = container.map do |item|
          cbfms = checkbox_for_multiple_select(name, item, selected_items, alt, options)
          alt = !alt if alternate
          cbfms
        end
        
        checkboxes_for_multiple_select.join("\n")
      end
    
    private
      
      # Accepts an item and returns a checkbox tag. If the item respond to first
      # and last (such a two element array), the "last" serve as checkbox value
      # and the "first" as label text. If the item is included in the
      # <tt>selected_items</tt> its checkbox will be selected. The
      # <tt>is_alternate</tt> determines if the checkbox will use the alternate
      # class name or not.
      #
      # If the option <tt>:position</tt> is provided the specified
      # position is used (<tt>:left</tt> or <tt>:right</tt>), otherwise the
      # default <tt>:right</tt> position is used.
      #
      # The <tt>:inner_class</tt> option specifies the base class of the div that
      # surrounds the checkbox and the label.
      #
      # The <tt>:alternate_class</tt> option allow to specify
      # a additional class that will be used in the element if
      # <tt>is_alternate</tt> is <tt>true</tt>.
      #
      # The <tt>:disabled</tt> option specifies if the checkbox will be rendered
      # disabled or not. Disabled can be <tt>true</tt>, <tt>false</tt> or an
      # array of values that will be disabled. By default the checkbox will not
      # be disabled.
      def checkbox_for_multiple_select(name, item, selected_items = [], is_alternate = false, options = {})
        position = (options[:position] or :right)
        inner_class = options[:inner_class]
        alternate_class = (options[:alternate_class] or 'alt')
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
        
        item_class = is_alternate ? "#{inner_class} #{alternate_class}".strip : inner_class
        
        content_tag('div', position == :left ? lbt + cbt : cbt + lbt, :class => item_class)
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