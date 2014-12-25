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
    before do
      visit(admin_root_path)
      find('#universities').find('a').click
    end

    scenario "Admin creats University", :js => false do
      click_link I18n.t(:'active_admin.new_model', {model: I18n.t(:'activerecord.models.university')})
      fill_form(:university, attributes_for(:university, code: "NTUST", name: "臺灣科技大學", short_name: "台科大"))
      find('#university_submit_action').find('input').click

      expect(page).to have_content('NTUST')
      expect(page).to have_content('臺灣科技大學')
      expect(page).to have_content('台科大')

      expect(University.where(code: :NTUST).last).to be_a(Object)
    end

    scenario "Admin views a University", :js => false do
      create(:university_ntust)
      visit(current_path)
      click_link 'NTUST'

      expect(page).to have_content('NTUST')
      expect(page).to have_content('臺灣科技大學')
      expect(page).to have_content('台科大')
    end
  end

  describe "University Unit Control Panel" do
    include_context "login to admin panel"
    let!(:university) { create(:university) }
    before do
      visit(admin_root_path)
      find('#units').find('a').click
    end

    scenario "Admin creats University Unit", :js => false do
      click_link I18n.t(:'active_admin.new_model', {model: I18n.t(:'activerecord.models.unit')})
      fill_form(:unit, {code: "OSA", name: "學生事務處", short_name: "學務處"})
      find("option[value='#{university.code}']").select_option
      find('#unit_submit_action').find('input').click

      expect(page).to have_content('OSA')

      osa = university.units.where(code: :OSA).last

      expect(osa).to be_a(Object)
      expect(osa.university_code).to eq(university.code)
      expect(osa.code).to eq("OSA")
      expect(osa.name).to eq("學生事務處")
      expect(osa.short_name).to eq("學務處")
    end

    xscenario "Admin views a Unit", :js => false do
      create(:university_ntust)
      visit(current_path)
      click_link '01'

      expect(page).to have_content('')
      expect(page).to have_content('')
      expect(page).to have_content('')
    end
  end

  describe "University College Control Panel" do
    include_context "login to admin panel"
    let!(:university) { create(:university) }
    before do
      visit(admin_root_path)
      find('#colleges').find('a').click
    end

    scenario "Admin creats University College", :js => false do
      click_link I18n.t(:'active_admin.new_model', {model: I18n.t(:'activerecord.models.college')})
      fill_form(:college, {code: "1", name: "設計學院", short_name: "設計"})
      find("option[value='#{university.code}']").select_option
      find('#college_submit_action').find('input').click

      expect(page).to have_content('設計學院')

      dc = university.colleges.where(code: '1').last

      expect(dc).to be_a(Object)
      expect(dc.university_code).to eq(university.code)
      expect(dc.code).to eq("1")
      expect(dc.name).to eq("設計學院")
      expect(dc.short_name).to eq("設計")
    end

    scenario "Admin views a College", :js => false do
      create(:university_ntust)
      visit(current_path)
      click_link '管理學院'

      expect(page).to have_content('管理學院')
    end
  end

  describe "University Department Control Panel" do
    include_context "login to admin panel"
    let!(:university) { create(:university) }
    before do
      visit(admin_root_path)
      find('#departments').find('a').click
    end

    scenario "Admin creats University Department", :js => false do
      click_link I18n.t(:'active_admin.new_model', {model: I18n.t(:'activerecord.models.department')})
      fill_form(:department, {code: "CS", name: "資訊工程系", short_name: "資工系"})
      find("option[value='#{university.code}']").select_option
      find('#department_submit_action').find('input').click

      expect(page).to have_content('CS')

      cs = university.departments.where(code: :CS).last

      expect(cs).to be_a(Object)
      expect(cs.university_code).to eq(university.code)
      expect(cs.code).to eq("CS")
      expect(cs.name).to eq("資訊工程系")
      expect(cs.short_name).to eq("資工系")
    end

    scenario "Admin views a department", :js => false do
      create(:university_ntust)
      visit(current_path)
      click_link '32'

      expect(page).to have_content('32')
      expect(page).to have_content('電資學士班')
      expect(page).to have_content('電資')
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
