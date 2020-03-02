class AddNotNullsToQuestions < ActiveRecord::Migration[5.2]
  def up
    change_column :questions, :user_id, :bigint, null: false
    change_column :questions, :title, :string, null: false
    change_column :questions, :description, :text, null: false
    change_column :questions, :tags, :string, null: false, default: ''
    change_column :questions, :slug, :string, null: false
  end
end
