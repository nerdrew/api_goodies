require 'spec_helper'

describe APIGoodies::ScopeUUID do
  build_model :bar do
    string :uuid
  end

  build_model :foo do
    integer :bar_id
    belongs_to :bar
    scope_uuid :bar
  end

  subject { Foo.new }
  let(:described_class) { Foo }
  it_behaves_like 'scope_uuid', :bar do
    valid_model(:bar) {|attributes = {}| Bar.new attributes.reverse_merge(uuid: SecureRandom.uuid) }
  end
end
