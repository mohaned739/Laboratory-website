class Report < ApplicationRecord
    belongs_to :user
    validates :rbc_count, :wbc_count, :plat_count, presence: true
end
