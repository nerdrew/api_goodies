require 'spec_helper'

describe APIGoodies::IsSoftDeletable do
  build_model :random_dude do
    datetime :deleted_at
    boolean :deleted, null: false, default: false

    is_soft_deletable
  end

  subject { RandomDude.new }
  let(:described_class) { RandomDude }
  it_behaves_like 'is_soft_deletable'
end
