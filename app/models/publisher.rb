class Publisher < ApplicationRecord
    validates :name, :header, :footer, presence: true
    has_rich_text :header
    has_rich_text :footer
    has_many :publisher_contents
    after_save :reload_routes
    def reload_routes
        if self.name_changed?
            Redis.send("rails_routes_ts", "expired")
        end
    end
end
