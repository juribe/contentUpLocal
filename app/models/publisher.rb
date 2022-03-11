class Publisher < ApplicationRecord
    validates :name, :header, :footer, presence: true
    has_rich_text :header
    has_rich_text :footer
    has_many :publisher_contents
end
