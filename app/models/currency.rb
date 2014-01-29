class Currency < ActiveRecord::Base

  DollarID = 1

  def to_s
    self.code
  end
end
