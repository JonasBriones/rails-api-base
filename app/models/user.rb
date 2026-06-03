# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum :role, { basic: 0, subscriber: 1, admin: 2 }, default: :basic

  validates :fullName, presence: true

  validates :dni, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, presence: true
  validate :date_of_birth_cannot_be_in_the_future

  def admin?
    role == 'admin'
  end

  private

  def date_of_birth_cannot_be_in_the_future
    return unless date_of_birth.present? && date_of_birth > Time.zone.today

    errors.add(:date_of_birth, "can't be in the future")
  end
end
