class Event < ApplicationRecord
  has_many :tickets

  validates :artist, presence: true, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :price_high, presence: true, numericality: { only_numerical: true }
  validates :price_low, presence: true, numericality: { only_numerical: true }
  validates :event_date, presence: true
  validates :max_places, presence: true, numericality: { only_numerical: true }


  validate :event_date_not_from_past, :max_more_than_min, :above_zero

  def event_date_not_from_past
    if event_date
      if event_date < Date.today
        errors.add('Date cannot', 'be from the past')
      end
    end
  end

  def max_more_than_min
    if price_high && price_low
      if price_high < price_low
        errors.add('Price max cannot', 'be lower than price min')
      end
    end
  end

  def above_zero
    if price_high && price_low
      if price_high <= 0.0 or price_low <= 0.0
        errors.add('Price must', 'be above 0')
      end
    end
  end

  def self.filter(event_date_from, event_date_to)
    if event_date_from != '' && event_date_to != '' && event_date_from && event_date_to
      Event.where({event_date:(Date.parse(event_date_from)..Date.parse(event_date_to))})
    else
      Event.all
    end
  end
  

end
