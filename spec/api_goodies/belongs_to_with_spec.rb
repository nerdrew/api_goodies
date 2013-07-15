require 'spec_helper'

describe APIGoodies::BelongsToWith do
  describe 'non-polymorphic belongs_to associations' do
    build_model :baz do
      string :uuid
    end

    build_model :foo do
      extend APIGoodies::BelongsToWith
      integer :baz_id

      belongs_to_with :uuid, :baz
    end

    it_behaves_like 'api_goodies gem belongs_to_with', :uuid, :baz do
      valid_model(:baz) { Baz.new uuid: SecureRandom.uuid }
      subject { Foo.new }
    end
  end

  describe 'polymorphic belongs_to associations' do
    build_model :baz do
      string :uuid
    end

    build_model :foo do
      extend APIGoodies::BelongsToWith
      integer :barable_id
      string :barable_type

      belongs_to_with :uuid, :barable, polymorphic: true
    end

    it_behaves_like 'api_goodies gem polymorphic_belongs_to_with', :uuid, :barable do
      valid_model(:barable) { Baz.new uuid: SecureRandom.uuid }
      subject { Foo.new }
    end
  end

  describe 'has_and_belongs_to_many_with' do
    build_model :baz do
      string :uuid
    end

    build_model :bazs_foo do
      integer :baz_id
      integer :foo_id
    end

    build_model :foo do
      extend APIGoodies::BelongsToWith
      has_and_belongs_to_many_with :uuid, :bazs
    end

    it_behaves_like 'api_goodies gem has_and_belongs_to_many_with', :uuid, :bazs do
      valid_model(:bazs) { Baz.new(uuid: SecureRandom.uuid) }
      subject { Foo.new }
    end
  end

end
