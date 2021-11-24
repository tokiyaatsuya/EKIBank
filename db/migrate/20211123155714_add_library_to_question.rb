class AddLibraryToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :library, :string
  end
end
