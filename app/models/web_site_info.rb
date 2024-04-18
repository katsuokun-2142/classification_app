class WebSiteInfo < ApplicationRecord
  belongs_to :category
  has_many :sinfo_scategories,  dependent: :destroy
  has_many :sub_categories,     through:   :sinfo_scategories
end
