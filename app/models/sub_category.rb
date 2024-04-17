class SubCategory < ApplicationRecord
  has_many :web_site_info,    through:   :sinfo_scategory
  has_many :sinfo_scategory,  dependent: :destroy
end
