class CreateExchangeRates < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.references :currency, index: true
      t.references :company, index: true
      t.float :purchase
      t.float :sale
      t.float :average

      t.timestamps
    end
  end
end
