require 'rails_helper'

feature "Control Panel University", :type => :feature do
  include_context "login to admin panel"

  scenario "Admin creats university", :js => false do
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
