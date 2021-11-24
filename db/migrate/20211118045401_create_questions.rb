class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :rent_budget
      t.string :buying_budget_1
      t.string :buying_budget_2

      t.timestamps
    end
  end
end
