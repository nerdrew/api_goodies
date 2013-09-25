module APIGoodies
  module IsSoftDeletable
    def is_soft_deletable
      self.send :include, InstanceMethods

      scope :active, ->{ where(deleted: false) }

      begin
        attr_protected :deleted, :deleted_at
      rescue RuntimeError => e
        raise e if e.message !~ /`attr_protected`/
      end
    end

    module InstanceMethods
      def soft_delete
        update_column(:deleted, true)
        update_column(:deleted_at, Time.now)
      end
    end
  end
end
