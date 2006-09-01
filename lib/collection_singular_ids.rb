module ActiveRecord #:nodoc:
  module Associations #:nodoc:
    module ClassMethods #:nodoc:
      
      alias_method :has_many_without_ids, :has_many
      alias_method :has_and_belongs_to_many_without_ids, :has_and_belongs_to_many
      
      def has_many_with_ids(association_id, options = {}, &extension)
        has_many_without_ids(association_id, options, &extension)
        
        reflection = create_has_many_reflection(association_id, options, &extension)
        define_method("#{reflection.name.to_s.singularize}_ids") do
          send(reflection.name).map(&:id)
        end unless options[:through]
      end
      
      def has_and_belongs_to_many_with_ids(association_id, options = {}, &extension)
        has_and_belongs_to_many_without_ids(association_id, options, &extension)
        
        reflection = create_has_and_belongs_to_many_reflection(association_id, options, &extension)
        define_method("#{reflection.name.to_s.singularize}_ids") do
          send(reflection.name).map(&:id)
        end
      end
      
      alias_method :has_many, :has_many_with_ids
      alias_method :has_and_belongs_to_many, :has_and_belongs_to_many_with_ids
    end
  end
end