#   has_and_belongs_to_many_with :name, :foos
#
# is the same as the following
#
#   has_and_belongs_to_many :foos
#
#   def foos_names
#     foos.map &:name
#   end
#
#   def foos_names= names
#     self.foos = Foo.where(name: names).all
#   end
module APIGoodies
  module HasAndBelongsToManyWith

    def has_and_belongs_to_many_with(attribute_name, name, options = {})
      has_and_belongs_to_many name, options

      singular_association_name = name.to_s.singularize
      plurazlized_attribute_name = attribute_name.to_s.pluralize

      class_eval <<-CODE, __FILE__, __LINE__ + 1
        attr_writer :#{singular_association_name}_#{plurazlized_attribute_name}
        before_validation :set_#{name}_from_#{plurazlized_attribute_name}

        alias_method :old_#{name}, :#{name}

        def #{name}
          if @#{singular_association_name}_#{plurazlized_attribute_name}.nil?
            old_#{name}
          else
            set_#{name}_from_#{plurazlized_attribute_name}
          end
        end

        def #{singular_association_name}_#{plurazlized_attribute_name}
          @#{singular_association_name}_#{plurazlized_attribute_name} || #{name}.map(&:#{attribute_name})
        end

        private

        def set_#{name}_from_#{plurazlized_attribute_name}
          if @#{singular_association_name}_#{plurazlized_attribute_name}
            other_class = association(:"#{name}").klass
            return if other_class.nil?
            self.#{name} = tmp = other_class.where(#{attribute_name}: @#{singular_association_name}_#{plurazlized_attribute_name}).to_a
            @#{singular_association_name}_#{plurazlized_attribute_name} = nil
            tmp
          end
        end
      CODE
    end
  end
end
