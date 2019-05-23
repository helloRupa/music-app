require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Register"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'email', :with => "testing@email.com"
      fill_in 'password', :with => "biscuits"
      click_on "Sign Up"
    end

    scenario "redirects to login page after signup" do
      expect(current_url).to eq(new_session_url)
    end
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'email', :with => "testing@email.com"
      click_on "Sign Up"
    end

    scenario "re-renders the signup page after failed signup" do
      expect(current_url).to eq(users_url)
      expect(page).to have_content('Password is too short')
    end
  end

end