class Game < ActiveRecord::Base
  has_many :questions, -> { order("position ASC") }, inverse_of: :game
end
