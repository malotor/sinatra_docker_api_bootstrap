require_relative '../acceptance_helper'

feature "Service status" do

  scenario "Check service is up" do
    visit '/'
    expect(page).to have_content( { status: 'UP' }.to_json )
  end
end
