require 'rqrcode'

class Order < ApplicationRecord
  attr_accessor :qr_code

  validates :address, presence: true
  validates :city, presence: true
  validates :phone, presence: true
  belongs_to :user
end
