require 'rails_helper'

RSpec.describe Advertisement, type: :model do
   let (:advertisements) {Advertisement.create!(title: "New Ad Title", copy: "Text", price:2)}

   describe "attributes" do
     it "has a title, copy and price" do
       expect(advertisements).to have_attributes(title: "New Ad Title", copy: "Text", price:2)
     end
   end
end
