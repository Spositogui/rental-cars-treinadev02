class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  validates :start_date, :end_date, presence: true
  validate :end_date_must_be_grater_than_start_date

  def end_date_must_be_grater_than_start_date
    #return unless star_date.presence? || end_date.presence?
    if end_date < start_date
      errors.add(:end_date, 'deve ser maior que data de ínicio')
    end
    #if start_date.blank? || end_date.blank?
    #  return errors.add(:base, 'Datas devem existir')
    #end
  end
end
