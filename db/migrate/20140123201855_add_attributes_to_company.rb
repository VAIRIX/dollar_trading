class AddAttributesToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :url, :string
    add_column :companies, :search, :string
    add_column :companies, :currency_page, :string
  end
end
