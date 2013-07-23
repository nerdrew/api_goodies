require 'spec_helper'

describe APIGoodies::BelongsToWith do
  describe 'non-polymorphic belongs_to_with associations' do
    build_model :baz do
      string :name
    end

    build_model :foo do
      extend APIGoodies::BelongsToWith
      integer :baz_id

      belongs_to_with :name, :baz
    end

    it_behaves_like 'api_goodies gem belongs_to_with', :name, :baz do
      valid_model(:baz) { Baz.new name: SecureRandom.uuid }
      subject { Foo.new }
    end
  end

  describe 'polymorphic belongs_to associations' do
    build_model :baz do
      string :name
    end

    build_model :foo do
      extend APIGoodies::BelongsToWith
      integer :barable_id
      string :barable_type

      belongs_to_with :name, :barable, polymorphic: true
    end

    it_behaves_like 'api_goodies gem polymorphic_belongs_to_with', :name, :barable do
      valid_model(:barable) { Baz.new name: SecureRandom.uuid }
      subject { Foo.new }
    end
  end

  describe 'belongs_to_with!' do
    build_model :baz do
      string :name
    end

    build_model :foo do
      extend APIGoodies::BelongsToWith
      integer :baz_id

      belongs_to_with! :name, :baz
    end

    it_behaves_like 'api_goodies gem belongs_to_with!', :name, :baz do
      valid_model(:baz) { Baz.new name: SecureRandom.uuid }
      subject { Foo.new }
    end
  end
end
