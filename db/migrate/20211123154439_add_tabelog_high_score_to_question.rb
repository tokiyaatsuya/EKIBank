class AddTabelogHighScoreToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :tabelog_high_score, :string
  end
end
