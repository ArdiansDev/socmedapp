class Message < ApplicationRecord
    validates :to, presence: true
    validates :from, presence: true
    validates :body, presence: true
end
