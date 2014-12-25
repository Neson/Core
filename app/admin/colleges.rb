ActiveAdmin.register College do
  menu priority: 112, parent: "學校資料"
  config.sort_order = :university_code_asc

  permit_params :university_code, :code, :short_name, :name

  filter :university
  filter :code_cont
  filter :name
  filter :short_name
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column(:university) { |college| link_to college.university_code, admin_university_path(college.university) }
    column(:code) { |college| link_to college.code, admin_college_path(college) }
    column(:short_name) { |college| link_to college.short_name, admin_college_path(college) }
    column(:name) { |college| link_to college.name, admin_college_path(college) }
    id_column
    actions
  end

  form do |f|
    f.inputs do
      f.input :university_code, as: :select, collection: options_for_select(University.all.map { |u| [u.name, u.code] }, college.university_code)
      f.input :code
      f.input :name
      f.input :short_name
    end
    f.actions
  end
end
