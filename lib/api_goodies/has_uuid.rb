require 'uuid'

module APIGoodies
  module HasUuid
    def has_uuid
      self.send :include, InstanceMethods
      self.send :extend, ClassMethods

      before_validation :assign_uuid, on: :create
      validates :uuid, uniqueness: true, on: :create, if: ->(model){ model.valid_uuid_format? }

      begin
        attr_protected :uuid
      rescue RuntimeError => e
        raise e if e.message !~ /`attr_protected`/
      end
    end

    module ClassMethods
      def find_uuid(uuid)
        UUID.validate(uuid) ? where(uuid: uuid).first : nil
      end

      def find_uuid!(uuid)
        find_uuid(uuid) || raise(ActiveRecord::RecordNotFound)
      end
    end

    module InstanceMethods
      def uuid=(value)
        if self.new_record?
          self[:uuid] = value
        else
          raise ArgumentError, "Can't set the uuid after the object has been created (on #{self.class.name} with id: #{id})"
        end
      end

      protected

      def valid_uuid_format?
        if UUID.validate(uuid)
          true
        else
          errors.add(:uuid, 'does not have a valid format')
          false
        end
      end

      private

      def assign_uuid
        self.uuid = SecureRandom.uuid if self.uuid.blank?
      end
    end
  end
end