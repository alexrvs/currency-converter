class ConverterService
  attr_reader :base_currency, :convert_currency

  def initialize(args)
    @from = args[:from]
    @to = args[:to]
    @sum = args[:sum]
  end

  def retrieve
    begin
      base_currency
      calculate
    rescue StandardError => e
      puts "#{e.full_message}"
    end
  end

  private

  def base_currency
    Currency.find_by(_id: @from)
  end

  def rate
    rates = JSON.parse(base_currency.rates)
    rates[@to]
  end

  def calculate
    (@sum * rate).to_f
  end

end