class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates :name, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :email_address, presence: true
  validates :price, numericality: { only_numerical: true }
  validates :seat_id_seq, numericality: { only_numerical: true }
  validates :address, presence: true
  validates :phone, presence: true

  validate :price_in_range, :validate_each, :above_zero

  def price_in_range
    if price && event_id
      unless price < event.price_high && price > event.price_low
        errors.add('Price not from price',' range of the event')
      end
    end
  end

  def validate_each
    unless email_address =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors.add('Enter Proper', 'Email')
    end
  end

  def above_zero
    if price
      if price <= 0.0
        errors.add('Price must', 'be above 0')
      end
    end
  end
end
