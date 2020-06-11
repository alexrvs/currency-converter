class RateCreatorService

  def process(obj, response)
    create_rates(obj, response)
  end

  private

  def create_rates(obj, response)
    data = JSON.parse(response)
    if !data["error"].present?
      insert_data = data["rates"].map{|item| {symbol: item.first, coefficient: item.last}}
      obj.rates.create(insert_data)
    end
  end

end