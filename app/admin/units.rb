ActiveAdmin.register Unit do
  menu priority: 111, parent: "學校資料"
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
    column(:university) { |unit| link_to unit.university_code, admin_university_path(unit.university) }
    column(:code) { |unit| link_to unit.code, admin_unit_path(unit) }
    column(:short_name) { |unit| link_to unit.short_name, admin_unit_path(unit) }
    column(:name) { |unit| link_to unit.name, admin_unit_path(unit) }
    id_column
    actions
  end

  form do |f|
    f.inputs do
      f.input :university_code, as: :select, collection: options_for_select(University.all.map { |u| [u.name, u.code] }, unit.university_code)
      f.input :code
      f.input :name
      f.input :short_name
    end
    f.actions
  end
end
