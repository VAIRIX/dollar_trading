class HomeController < ApplicationController
  def index
  	@companies = Company.activated
  end

  def hisotry_exchange_rate
  	@company = Company.friendly.find params[:company_id]
  	@exchange_rates = @company.exchange_rates.order(created_at: :desc)
  	@title = "Cotizaciones de la empresa " + @company.name
  	@description = "Cotizaciones de la empresa " + @company.name
  end

end
