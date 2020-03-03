require 'rails_helper'

describe Questions::Update do

  let(:user) { User.create(email: 'asdf@adfs.cd', password: 'asdfasd') }
  let(:question) {
    Question.create(
      user: user,
      title: 'Why tho?',
      description: 'You already know',
      tags: ''
    )
  }

  context 'with a new title' do
    let :params do
      {
        title: 'How many roads?'
      }
    end

    let(:service) { Questions::Update.new(question, params) }
    let!(:result) { service.run }

    it 'runs succesfully' do
      expect(result).to eq(true)
    end

    it 'title been updated' do
      expect(question.reload.title).to eq('How many roads?')
    end

    it 'slug been updated' do
      expect(question.reload.slug).to eq('how-many-roads')
    end
  end

end
