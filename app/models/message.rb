class Message < ApplicationRecord
    validates :content, presence: true
    validates :message_type, inclusion: { in: %w[greeting help fun_fact unknown] }
  end
  
