class Content < ApplicationRecord
    validates :title, :content, presence: true
    has_rich_text :content
end
