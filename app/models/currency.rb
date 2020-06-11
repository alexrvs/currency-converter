class Currency
  include Mongoid::Document
  include Mongoid::Timestamps

  field :api_id, type: String
  field :name, type: String
  field :symbol, type: String

  has_many :rates, dependent: :destroy

end
