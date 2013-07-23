require 'spec_helper'

describe APIGoodies::HasAndBelongsToManyWith do
  describe 'has_and_belongs_to_many_with' do
    build_model :baz do
      string :uuid
    end

    build_model :bazs_foo do
      integer :baz_id
      integer :foo_id
    end

    build_model :foo do
      extend APIGoodies::HasAndBelongsToManyWith
      has_and_belongs_to_many_with :uuid, :bazs
    end

    it_behaves_like 'api_goodies gem has_and_belongs_to_many_with', :uuid, :bazs do
      valid_model(:bazs) { Baz.new(uuid: SecureRandom.uuid) }
      subject { Foo.new }
    end
  end

end
