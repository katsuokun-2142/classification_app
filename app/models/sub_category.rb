class SubCategory < ApplicationRecord
  has_many :sinfo_scategories,  dependent: :destroy
  has_many :web_site_infos,    through:   :sinfo_scategories
end
