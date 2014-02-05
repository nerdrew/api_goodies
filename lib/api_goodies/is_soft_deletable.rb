module APIGoodies
  module IsSoftDeletable
    def is_soft_deletable
      # TODO have separate modules for rails3 vs rails4
      self.send :include, InstanceMethods
      self.send :extend, ClassMethods

      scope :active, ->{ where(deleted: false) }

      define_model_callbacks :soft_delete

      begin
        attr_protected :deleted, :deleted_at
      rescue RuntimeError => e
        raise e if e.message !~ /`attr_protected`/
      end
    end

    module ClassMethods
      def soft_delete
        update_all(deleted: true, deleted_at: Time.now)
      end
    end

    module InstanceMethods
      def soft_delete
        run_callbacks :soft_delete do
          update_columns(deleted: true, deleted_at: Time.now)
        end
      end
    end
  end
end
