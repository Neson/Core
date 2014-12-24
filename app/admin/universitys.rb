ActiveAdmin.register University do
  menu priority: 110, parent: "學校資料"
  config.sort_order = :code_asc

  permit_params :code, :name, :short_name, email_patterns_attributes: [:_destroy, :id, :priority, :identity, :regexp, :sid_eval, :identity_detail_eval, :department_code_eval, :unit_code_eval, :started_at_eval]

  filter :code_cont
  filter :name
  filter :short_name

  index do
    selectable_column
    column(:code) { |university| link_to university.code, admin_university_path(university) }
    column :short_name
    column :name
    id_column
    actions
  end

  sidebar "說明", only: :edit do
    p 'Some description...'
  end

  form do |f|
    f.inputs "基本資料" do
      f.input :code
      f.input :name
      f.input :short_name
    end
    f.inputs "資料集" do
      # f.has_many :email_patterns, allow_destroy: true, new_record: true, sortable: :priority do |ep|
      f.has_many :email_patterns, allow_destroy: true, new_record: true do |ep|
        ep.input :priority, hint: "數字越小優先級越高，較嚴謹的規則應被排在較高的優先級"
        ep.input :regexp, hint: "可使用 named capturing groups 抓取資料，有效的 group name 有：sid (學號)、identity_detail (身份細節)、department_code (系所代碼)、unit_code (所屬單位代碼)、started_at (身份開始日期)，例如：`^(?<sid>(?<identity_detail>[aAbmdBMD])(?<started_at>\d*)(?<department_code>\d{2})\d{3})@mail\.ntust\.edu\.tw$`"

        ep.input :identity, as: :select, collection: Constant::USER_IDENTITY.keys, hint: "符合此規則的使用者該被賦予的身份"

        ep.input :sid_eval, hint: "將抓取出的 <sid> 字串轉換成正確學號資料的 JavaScript 程式碼，可用變數 n 取得原始資料，空白表示不處理，例如：`n.toLowerCase()`"
        ep.input :identity_detail_eval, hint: "將抓取出的 <identity_detail> 字串轉換成正確詳細身份資料的 JavaScript 程式碼，可用變數 n 取得原始資料，空白表示不處理，例如：`switch (n.toLowerCase()) { case 'a': 'a'; break; case 'b': 'bachelor'; break; case 'm': 'master'; break; case 'd': 'doctor'; break; }`"
        ep.input :department_code_eval, hint: "將抓取出的 <department_code> 字串轉換成正確系所代碼資料的 JavaScript 程式碼，可用變數 n 取得原始資料，空白表示不處理"
        ep.input :unit_code_eval, hint: "將抓取出的 <unit_code> 字串轉換成正確單位代碼資料的 JavaScript 程式碼，可用變數 n 取得原始資料，空白表示不處理"
        ep.input :started_at_eval, hint: "將抓取出的 <started_at> 字串轉換成正確開始日期資料的 JavaScript 程式碼，可用變數 n 取得原始資料，空白表示不處理，例如：`new Date((parseInt(n)+1911) + '-9')`"
      end
    end
    f.actions
  end

end
