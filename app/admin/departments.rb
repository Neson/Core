ActiveAdmin.register Department do
  menu priority: 113, parent: "學校資料"
  config.sort_order = :university_code_asc

  permit_params :university_code, :college_code, :code, :short_name, :name

  filter :university
  filter :college
  filter :code_cont
  filter :name
  filter :short_name
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column(:university) { |department| link_to department.university_code, admin_university_path(department.university) }
    column(:college) { |department| link_to(department.college_short_name, admin_college_path(department.college)) if department.college_short_name }
    column(:code) { |department| link_to department.code, admin_department_path(department) }
    column(:short_name) { |department| link_to department.short_name, admin_department_path(department) }
    column(:name) { |department| link_to department.name, admin_department_path(department) }
    id_column
    actions
  end

  form do |f|
    f.inputs do
      f.input :university_code, as: :select, collection: options_for_select(University.all.map { |u| [u.name, u.code] }, department.university_code)
      f.input :college_code, as: :select, collection: options_for_select(College.all.map { |u| [u.name, u.code] }, department.college_code)
      f.input :code
      f.input :name
      f.input :short_name
    end
    f.actions
  end
end
