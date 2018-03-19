require_relative '../../acceptance_helper'

feature "Working with articles" do

  scenario "List all articles" do
    visit '/articles'
    expect(response).to be_success
  end
end
