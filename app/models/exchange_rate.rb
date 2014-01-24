class ExchangeRate < ActiveRecord::Base
  belongs_to :currency
  belongs_to :company

  def self.last_of_the_company(company_id)
  	exchangeRate = ExchangeRate.where(company_id: company_id).order(created_at: :desc).limit(1)
  	exchangeRate[0]
  end

  def equals?(exchangeRate)
  	self.purchase == exchangeRate.purchase && self.sale == exchangeRate.sale && self.average == exchangeRate.average
  end
end
