def random_views
  (rand() * 10_000).round(0)
end

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
    title: "How do I vet a potential employee?",
    description: "Vetting is the process of performing a background check on someone before offering them employment, conferring an award, or doing fact-checking prior to making any decision. In addition, in intelligence gathering, assets are vetted to determine their usefulness.",
    tags: "employment,procurement,business,risk",
    views: random_views,
    created_at: Time.now - 1.hour,
    updated_at: Time.now - 1.hour
  )

  Question.create(
    user: user,
    title: "How many hours of sleep should I aim for?",
    description: "The title says it all, really.",
    tags: "sleep,work,health,lifestyle",
    views: random_views
  )

  Question.create(
    user: user,
    title: "How is life as a web developer who works remotely?",
    description: "The title says it all, really.",
    tags: "work,health,lifestyle,remote",
    views: random_views
  )

  Question.create(
    user: user,
    title: "What's a single line of code that almost caused a catastrophe?",
    description: "The title says it all, really.",
    tags: "code,failure,safety",
    views: random_views
  )

  Question.create(
    user: user,
    title: "Why do most top Computer Science students choose to become a backend developer instead of frontend developers?",
    description: "The title says it all, really.",
    tags: "education,web development,front end, back end",
    views: random_views
  )

  Question.create(
    user: user,
    title: "What are the dirty little secrets of a back-end developer?",
    description: "The title says it all, really.",
    tags: "back end,web development,secrets",
    views: random_views
  )
end
