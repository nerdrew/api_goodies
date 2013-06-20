require 'spec_helper'

describe APIGoodies::HasDefaultStatus do
  build_model :modely do
    has_default_status

    integer :status_id
  end

  build_model :status do
    string :name
  end

  subject { Modely.new }
  it_behaves_like 'has_default_status'
end
