class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  has_one :car_rental
  has_one :car, through: :car_rental

  validates :start_date, :end_date, presence: true
  validate :end_date_must_be_grater_than_start_date
  validate :start_date_must_be_grater_than_current_day

  enum status: {scheduled: 0, in_progress: 5}

  def end_date_must_be_grater_than_start_date
    return if start_date.blank? || end_date.blank?
    
    if end_date <= start_date
      errors.add(:end_date, 'deve ser maior que data de ínicio')
    end
  end

  def start_date_must_be_grater_than_current_day
    return if start_date.blank?

    if start_date <= Date.current
      errors.add(:start_date, 'deve ser maior que a data atual')
    end
  end
end
