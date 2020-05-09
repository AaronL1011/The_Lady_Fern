class ListingsPurchase < ApplicationRecord
  belongs_to :listing
  belongs_to :purchase
end
