require 'rails_helper'

describe Questions::Destroy do
  let(:user) { User.create(email: 'asdf@adfs.cd', password: 'asdfasd') }
  let(:service) { Questions::Destroy.new(question, user) }
  let!(:result) { service.run }

  context 'destroying a question you created' do
    let(:question) {
      Question.create(
        user: user,
        title: 'Why tho?',
        description: 'You already know',
        tags: ''
      )
    }

    it 'runs succesfully' do
      expect(result).to eq(true)
    end

    it 'question has been destroyed' do
      expect {
        question.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'destroying a question that does not belong to you' do
    let(:other_user) { User.create(email: 'ff@ffff.ff', password: 'fffff') }
    let(:question) {
      Question.create(
        user: other_user,
        title: 'Why tho?',
        description: 'You already know',
        tags: ''
      )
    }

    it 'does not run succesfully' do
      expect(result).to eq(false)
    end

    it 'adds an error message' do
      expect(question.errors.messages[:base][0]).to eq('You are not permitted to delete this question')
    end

    it 'question has not been destroyed' do
      expect {
        question.reload
      }.not_to raise_error
    end
  end

end
