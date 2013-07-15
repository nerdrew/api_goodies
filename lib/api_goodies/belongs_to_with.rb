# In the API we want to do this:
#
#   Foo.new bar_uuid: 'MERCH-123'
#
# and have the new Foo lookup the Bar by UUID or this:
#
#   Baz.new goat_name: 'Visa'
#
# and have the Baz lookup the Goat by name.
#
# You can't do:
#
#   belongs_to :contactable, polymorphic: true
#
#   def contactable_uuid= uuid
#     ContactableIsNotAClass.find_by_uuid uuid
#   end
#
# if the association is polymorphic (hence the before_validation and instance variable).
#
# What this does:
# - Creates a belongs_to <name>
# - Adds reader/writer methods: <name>_<attribute_name>
# - Adds a before_validation callback that does a lookup on the association by the <attribute_name>
# - Overwrites the standard association so that we can set the associated model if we need to
#
# E.g. for a non-polymorphic association:
#
#   belongs_to_with :name, :goat
#
# is the same as the following (as long as it isn't polymorphic)
#
#   belongs_to :goat
#
#   def goat_name
#     goat.name
#   end
#
#   def goat_name= name
#     self.goat = Goat.find_by_name name
#   end
#

module APIGoodies
  module BelongsToWith
    def belongs_to_with(attribute_name, name, options = {})
      belongs_to name, options

      class_eval <<-CODE, __FILE__, __LINE__ + 1
        attr_writer :#{name}_#{attribute_name}
        before_validation :set_#{name}_from_#{attribute_name}

        alias_method :old_#{name}, :#{name}

        def #{name}
          if @#{name}_#{attribute_name}.nil?
            old_#{name}
          else
            set_#{name}_from_#{attribute_name}
          end
        end

        def #{name}_#{attribute_name}
          @#{name}_#{attribute_name} || #{name}.#{attribute_name}
        end

        private

        def set_#{name}_from_#{attribute_name}
          if @#{name}_#{attribute_name}
            other_class = association(:"#{name}").klass
            return if other_class.nil?
            self.#{name} = other_class.where(#{attribute_name}: @#{name}_#{attribute_name}).first
          end
        end
      CODE
    end

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
