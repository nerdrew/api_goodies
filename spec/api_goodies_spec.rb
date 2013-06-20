require 'spec_helper'

describe APIGoodies do
  it 'should have a version number' do
    APIGoodies::VERSION.should_not be_nil
  end
end
