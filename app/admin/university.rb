ActiveAdmin.register University do
  menu priority: 110, parent: "學校資料"

  permit_params :code, :name, :short_name

  filter :code_cont
  filter :name
  filter :short_name

  index do
    selectable_column
    id_column
    column :code
    column :name
    column :short_name
    actions
  end
end
