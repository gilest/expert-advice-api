require 'rails_helper'

describe Questions::Create do

  let(:user) { User.create(email: 'asdf@adfs.cd', password: 'asdfasd') }

  context 'with valid params' do
    let :params do
      {
        title: "How many roads must a man walk down?",
        description: "Perhaps the answer is blowing in the wind...",
        tags: "WiNd,Bob-dylan,cryptic_lyrics,cryptic  lyrics",
        user: user
      }
    end

    let(:service) { Questions::Create.new(params) }
    let!(:result) { service.run }

    it 'runs succesfully' do
      expect(result).to eq(true)
    end

    it 'tag format has been transformed' do
      expect(service.question.tags).to eq('bob dylan,cryptic lyrics,wind')
    end
  end

end
