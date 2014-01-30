every 2.hours do
  runner "Company.search_dollar", :output => {:error => '/var/www/dollar_trading/log/error.log'}
end