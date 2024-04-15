class SinfoScategory < ApplicationRecord
  belongs_to :web_site_info
  belongs_to :sub_category
end
