class Question < ApplicationRecord
  extend SortQuestions
  belongs_to :user
end
