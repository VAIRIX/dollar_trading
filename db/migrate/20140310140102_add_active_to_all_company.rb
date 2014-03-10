class AddActiveToAllCompany < ActiveRecord::Migration
  def self.up
    Company.all.each do |company|
      company.active = true
      company.save(validate: false)
    end
  end
end
