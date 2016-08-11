class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :answers
      t.references :user

      t.timestamps
    end
  end
end
