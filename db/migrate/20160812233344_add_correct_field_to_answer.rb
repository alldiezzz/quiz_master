class AddCorrectFieldToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :correct, :bool
  end
end
