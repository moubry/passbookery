class AddWhichToPass < ActiveRecord::Migration
  def change
    add_column :passes, :which, :string
  end
end
