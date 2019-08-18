class Game < ApplicationRecord
    serialize :board, JSON
end
