class Order
  include Mongoid::Document

  field :product_name, type: String
  field :owner, type: String
  field :address, type: String
  field :quantity, type: Integer

  validates :product_name, presence: true
  validates :owner, presence: true
  validates :address, presence: true

  index({ product_name: 'text' })
end