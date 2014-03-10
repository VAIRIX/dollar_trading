class AddActiveToCompany < ActiveRecord::Migration
  def up
    add_column :companies, :active, :boolean
  end

  def down
    remove_column :companies, :active
  end
end
