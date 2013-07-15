require 'spec_helper'

describe APIGoodies::HasUuid do
  build_model :elegant_german_beer_stein do
    string :uuid, limit: 36, null: false, default: ""
    boolean :foo

    has_uuid
  end

  subject { ElegantGermanBeerStein.new }
  let(:described_class) { ElegantGermanBeerStein }
  it_behaves_like 'api_goodies gem has_uuid'
end
