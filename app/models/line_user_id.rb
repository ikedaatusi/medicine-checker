class LineUserId < ApplicationRecord
    validates :uid, presence: true, uniqueness: true
end
