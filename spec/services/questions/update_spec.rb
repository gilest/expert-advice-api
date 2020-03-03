require 'rails_helper'

describe Questions::Update do
  let(:user) { User.create(email: 'asdf@adfs.cd', password: 'asdfasd') }
  let(:service) { Questions::Update.new(question, params, user) }
  let!(:result) { service.run }

  context 'updating a question you created' do
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

  context 'updating a question that does not belong to you' do
    let(:other_user) { User.create(email: 'ff@ffff.ff', password: 'fffff') }
    let(:question) {
      Question.create(
        user: other_user,
        title: 'Why tho?',
        description: 'You already know',
        tags: ''
      )
    }
    let :params do
      {
        title: 'Another one?'
      }
    end

    it 'does not run succesfully' do
      expect(result).to eq(false)
    end

    it 'adds an error message' do
      expect(question.errors.messages[:base][0]).to eq('You are not permitted to update this question')
    end
  end

end
