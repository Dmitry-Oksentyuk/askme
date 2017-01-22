class AddAuthorQuestionIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :author_question_id, :integer
  end
end
