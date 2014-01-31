class ExchangeRate < ActiveRecord::Base
  belongs_to :currency
  belongs_to :company

  def self.last_of_the_company(company_id)
  	exchangeRate = ExchangeRate.where(company_id: company_id).order(created_at: :desc).limit(1)
  	exchangeRate[0]
  end

  def self.exchange_dollar(purchase_value,sale_value, company)
    average_value = ((purchase_value + sale_value)/2).round(2)
    exchangeRate = ExchangeRate.new(company_id: company.id, currency_id: Currency::DollarID,purchase: purchase_value, sale: sale_value, average: average_value)
    last_exchangeRate = ExchangeRate.last_of_the_company(company.id)
    if (last_exchangeRate.nil? || !last_exchangeRate.equals?(exchangeRate))
      exchangeRate.save
    end
  end

  def equals?(exchangeRate)
  	self.purchase == exchangeRate.purchase && self.sale == exchangeRate.sale && self.average == exchangeRate.average
  end
end
