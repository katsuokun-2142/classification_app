class WebSiteInfo < ApplicationRecord
  belongs_to :category
  has_many :sub_category,     through:   :sinfo_scategory
  has_many :sinfo_scategory,  dependent: :destroy
end
