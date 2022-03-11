class PublisherContent < ApplicationRecord
    belongs_to :content
    belongs_to :publisher
end
