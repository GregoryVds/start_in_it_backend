class Track < ActiveRecord::Base
  has_many :exercises, dependent: :destroy, inverse_of: :track
  has_many :achievements, as: :achievable, dependent: :destroy, inverse_of: :exercise
  validates_presence_of :description, :difficulty, :name
  validates :difficulty, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end