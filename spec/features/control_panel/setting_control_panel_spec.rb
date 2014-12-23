require 'rails_helper'

feature "Control Panel Setting", :type => :feature do
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
