require 'rails_helper'

feature "Control Panel", :type => :feature do
  before :each do
    @admin_credentials = {username: 'test_admin', password: 'password'}
    @admin = create(:admin, @admin_credentials)
  end

  scenario "Admin signs in" do
    visit(new_admin_session_path)
    within("#login") do
      fill_in 'admin_username', with: @admin_credentials[:username]
      fill_in 'admin_password', with: @admin_credentials[:password]
      find("input[type=submit]").click
    end
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end

  describe "University Control Panel" do
    include_context "login to admin panel"

    scenario "Admin creats University", :js => false do
      visit(admin_root_path)
      find('#universities').find('a').click
      click_link I18n.t(:'active_admin.new_model', {model: I18n.t(:'activerecord.models.university')})
      fill_form(:university, attributes_for(:university, code: "NTUST", name: "臺灣科技大學", short_name: "台科大"))
      find('#university_submit_action').find('input').click

      expect(page).to have_content('NTUST')
      expect(page).to have_content('臺灣科技大學')
      expect(page).to have_content('台科大')
    end
  end

  describe "Setting Control Panel" do
    include_context "login to admin panel"

    scenario "Admin changes settings", :js => false do
      visit(admin_root_path)
      find('#setting').find('a').click
      within("#main_content") do
        all('input[type=text]').each_with_index { |input, i| input.set "input_val#{i}" }
        all('textarea').each_with_index { |input, i| input.set "textarea_val#{i}" }
        all('input[type=checkbox]').each_with_index { |input, i| input.set true }
        find("input[type=submit]").click
      end
      within("#main_content") do
        all('input[type=text]').each_with_index do |input, i|
          expect(input.value).to eq "input_val#{i}"
        end
        all('textarea').each_with_index do |input, i|
          expect(input.value).to eq "textarea_val#{i}"
        end
        all('input[type=checkbox]').each_with_index do |input, i|
          expect(input.value).to be_truthy
        end
      end
    end
  end
end
