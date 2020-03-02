ActiveRecord::Base.transaction do
  Doorkeeper::Application.destroy_all
  Doorkeeper::Application.create(name: "expert_advice_web", redirect_uri: "http://localhost:3000/")

  Question.destroy_all
  UserAccountAccess.destroy_all
  User.destroy_all
  Account.destroy_all

  user = User.create(email: "test@test.com", password: "test")
  account = user.accounts.create

  Question.create(
    user: user,
    title: "How many hours of sleep should I aim for?",
    description: "The title says it all, really.",
    tags: "sleep,work,health,lifestyle"
  )
end
