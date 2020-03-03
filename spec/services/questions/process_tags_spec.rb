require 'rails_helper'

describe Questions::ProcessTags do
  let(:tags) { 'WiNd,Bob-dylan,cryptic_lyrics,cryptic  lyrics' }
  let(:service) { Questions::ProcessTags.new(tags) }
  let(:result) { service.run }

  it 'transforms tags to the correct format' do
    expect(result).to eq('bob dylan,cryptic lyrics,wind')
  end
end
