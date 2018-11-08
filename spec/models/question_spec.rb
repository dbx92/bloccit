require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) {Question.create!(title: "New Question", resolved: true)}

  describe "attributes" do
    it "has title and boolean" do
      expect(question).to have_attributes(title:"New Question", resolved: true)
    end
  end
end
