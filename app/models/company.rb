#encoding: utf-8
class Company < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :exchange_rates

  NAMES_IDS = {:gales => 1, :cambio_18 => 2, :fortex => 3, :nixus => 4,
               :sir => 5, :suizo => 6, :bacacay => 7, :varlix => 8, :indumex => 9}

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
      when NAMES_IDS[:sir]
        sir(agent)
      when NAMES_IDS[:suizo]
        suizo(agent)
      when NAMES_IDS[:bacacay]
        bacacay(agent)
      when NAMES_IDS[:varlix]
        varlix(agent)
      when NAMES_IDS[:indumex]
        indumex(agent)
      end
  end

  private

  def gales(agent)
    rate = agent.page.search(self.search)[0].text.strip.split("\r\n")
    purchase_value = rate[1].gsub(',','.').to_f
    sale_value = rate[2].gsub(',','.').to_f
    ExchangeRate.exchange_dollar(purchase_value,sale_value, self)
  end

  def cambio_18(agent)
    rate = agent.page.search(self.search)[4].text.split('Dólar USA')[1].split('Euros')[0]
    purchase_value = rate.gsub("\n\t",'').gsub("\n",'').strip.split("\t\t\t\t\t\t\t")[0].to_f
    sale_value = rate.gsub("\n\t",'').gsub("\n",'').strip.split("\t\t\t\t\t\t\t")[1].to_f
    ExchangeRate.exchange_dollar(purchase_value,sale_value, self)
  end

  def fortex(agent)
    rate = agent.page.search(self.search)[0].text.split("\n\t\t\t\t\t")[0]
    purchase_value = rate[0..4].to_f
    sale_value = rate[5..9].to_f
    ExchangeRate.exchange_dollar(purchase_value,sale_value, self)
  end

  def nixus(agent)
    rate = agent.page.search(self.search)[0].text.split('Dólar')[1].split("\n")
    purchase_value = rate[1].strip.to_f
    sale_value = rate[2].strip.to_f
    ExchangeRate.exchange_dollar(purchase_value,sale_value, self)
  end

  def sir(agent)
    rate = agent.page.search(self.search).text.split('Dolares')[1]
    purchase_value = rate.split("\r\n")[1].strip.gsub(',','.').to_f
    sale_value = rate.split("\r\n")[2].strip.gsub(',','.').to_f
    ExchangeRate.exchange_dollar(purchase_value,sale_value, self)
  end

  def suizo(agent)
    rate = agent.page.search(self.search).text.split("|")
    purchase_value = rate[0].split("\n\t\t\t").last.strip.to_f
    sale_value = rate[1].split("\n")[1].strip.to_f
    ExchangeRate.exchange_dollar(purchase_value,sale_value, self)
  end

  def bacacay(agent)
    rate = agent.page.search(self.search).text.split("Dolar USA \n")[1].split("Euro")[0]
    purchase_value = rate.split("\n")[0].strip.to_f
    sale_value = rate.split("\n")[1].strip.to_f
    ExchangeRate.exchange_dollar(purchase_value,sale_value, self)
  end

  def varlix(agent)
    rate = agent.page.search(self.search).text.split("Dolar")[1].split("Peso Arg")[0]
    purchase_value = rate.split("\n")[1].strip.to_f
    sale_value = rate.split("\n")[2].strip.to_f
    ExchangeRate.exchange_dollar(purchase_value,sale_value, self)
  end

  def indumex(agent)
    rate = agent.page.search(self.search).text.split("Dolar")[1].split("Peso")[0]
    purchase_value = rate[0..4].gsub(',','.').to_f
    sale_value = rate[5..9].gsub(',','.').to_f
    ExchangeRate.exchange_dollar(purchase_value,sale_value, self)
  end

  def to_s
    self.name
  end
end
