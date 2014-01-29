class Company < ActiveRecord::Base

  has_many :exchange_rates

  NAMES_IDS = {:gales => 1, :cambio_18 => 2, :fortex => 3, :nixus => 4}

  attr_accessor :last_exchange

  def obtaining_last_exchange
    @last_exchange ||= self.exchange_rates.last
  end

  def self.search_dollar
    Company.all.each do |company|
      company.test
    end
  end

  def test
    agent = Mechanize.new
    agent.get(self.url)
    case self.id
      when NAMES_IDS[:gales]
        gales(agent)
      when NAMES_IDS[:cambio_18]
        cambio_18(agent)
      when NAMES_IDS[:fortex]
        fortex(agent)
      when NAMES_IDS[:nixus]
        nixus(agent)
      end
  end

  private

  def gales(agent)
    agent.page.search(self.search)[0]
    rate = agent.page.search(self.search)[0].text.strip.split("\r\n")
    purchase_value = rate[1].gsub(',','.').to_f
    sale_value = rate[2].gsub(',','.').to_f
    average_value = ((purchase_value + sale_value)/2).round(2)
    exchangeRate = ExchangeRate.new(company_id:self.id, currency_id: Currency::DollarID,purchase: purchase_value, sale: sale_value, average: average_value)
    last_exchangeRate = ExchangeRate.last_of_the_company(self.id)
    if (last_exchangeRate.nil? || !last_exchangeRate.equals?(exchangeRate))
      exchangeRate.save
    end
  end

  def cambio_18(agent)
    rate = agent.page.search(self.search)[4].text.split('Dólar USA')[1].split('Euros')[0]
    purchase_value = rate.gsub("\n\t",'').gsub("\n",'').strip.split("\t\t\t\t\t\t\t")[0].to_f
    sale_value = rate.gsub("\n\t",'').gsub("\n",'').strip.split("\t\t\t\t\t\t\t")[1].to_f
    average_value = ((purchase_value + sale_value)/2).round(2)
    exchangeRate = ExchangeRate.new(company_id:self.id, currency_id: Currency::DollarID,purchase: purchase_value, sale: sale_value, average: average_value)
    last_exchangeRate = ExchangeRate.last_of_the_company(self.id)
    if (last_exchangeRate.nil? || !last_exchangeRate.equals?(exchangeRate))
      exchangeRate.save
    end
  end

  def fortex(agent)
    rate = agent.page.search(self.search)[0].text.split("\n\t\t\t\t\t")[0]
    purchase_value = rate[0..4].to_f
    sale_value = rate[5..9].to_f
    average_value = ((purchase_value + sale_value)/2).round(2)
    exchangeRate = ExchangeRate.new(company_id:self.id, currency_id: Currency::DollarID,purchase: purchase_value, sale: sale_value, average: average_value)
    last_exchangeRate = ExchangeRate.last_of_the_company(self.id)
    if (last_exchangeRate.nil? || !last_exchangeRate.equals?(exchangeRate))
      exchangeRate.save
    end
  end

  def nixus(agent)
    rate = agent.page.search(self.search)[0].text.split('Dólar')[1].split("\n")
    purchase_value = rate[1].strip.to_f
    sale_value = rate[2].strip.to_f
    average_value = ((purchase_value + sale_value)/2).round(2)
    exchangeRate = ExchangeRate.new(company_id:self.id, currency_id: Currency::DollarID,purchase: purchase_value, sale: sale_value, average: average_value)
    last_exchangeRate = ExchangeRate.last_of_the_company(self.id)
    if (last_exchangeRate.nil? || !last_exchangeRate.equals?(exchangeRate))
      exchangeRate.save
    end
  end

  def to_s
    self.name
  end
end
