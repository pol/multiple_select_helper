module ActiveRecord #:nodoc:
  module Associations #:nodoc:
    module ClassMethods #:nodoc:
    private
      def collection_accessor_methods(reflection, association_proxy_class)
        # Taken from Rails 1.2.2
        collection_reader_method(reflection, association_proxy_class)

        define_method("#{reflection.name}=") do |new_value|
          # Loads proxy class instance (defined in collection_reader_method) if not already loaded
          association = send(reflection.name)
          association.replace(new_value)
          association
        end

        define_method("#{reflection.name.to_s.singularize}_ids") do
          send(reflection.name).map(&:id)
        end

        define_method("#{reflection.name.to_s.singularize}_ids=") do |new_value|
          ids = (new_value || []).reject { |nid| nid.blank? }
          send("#{reflection.name}=", reflection.class_name.constantize.find(ids))
        end
      end
    end
  end
end