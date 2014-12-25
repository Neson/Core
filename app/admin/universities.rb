ActiveAdmin.register University do
  menu priority: 110, parent: "學校資料"
  config.sort_order = :code_asc

  permit_params :code, :name, :short_name,
    email_patterns_attributes: [
      :_destroy,
      :id,
      :priority,
      :identity,
      :regexp,
      :sid_eval,
      :identity_detail_eval,
      :department_code_eval,
      :unit_code_eval,
      :started_at_eval
    ],
    units_attributes: [
      :_destroy,
      :id,
      :code,
      :short_name,
      :name
    ],
    colleges_attributes: [
      :_destroy,
      :id,
      :code,
      :short_name,
      :name
    ],
    departments_attributes: [
      :_destroy,
      :id,
      :code,
      :short_name,
      :name,
      :college,
      :college_code
    ]

  filter :code_cont
  filter :name
  filter :short_name
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column(:code) { |university| link_to university.code, admin_university_path(university) }
    column :short_name
    column :name
    id_column
    actions
  end

  sidebar "說明", only: [:edit, :new] do
    ul do
      li do
        strong '基本資料：'
        br
        text_node '代碼、簡稱、全名等基本資料'
      end
      li do
        strong 'Email 模型：'
        br
        text_node '當使用者驗證 Email 時，若符合模型所設規則，會自動開通該校身份，並填入資料'
      end
      li do
        strong '單位：'
        br
        text_node '校內單位'
      end
      li do
        strong '學院：'
        br
        text_node '學院底下可以有多個系所'
      end
      li do
        strong '系所：'
        br
        text_node '系所可以隸屬於一個學院'
      end
    end
  end

  show do
    attributes_table do
      row(:code)
      row(:name)
      row(:short_name)
    end

    panel 'Email 辨識模型' do
      attributes_table_for university.email_patterns do
        row(:priority)
        row(:identity)
        row(:regexp) { |ep| code(ep.regexp) }
        row(:sid_eval) { |ep| code(ep.sid_eval) }
        row(:identity_detail_eval) { |ep| code(ep.identity_detail_eval) }
        row(:department_code_eval) { |ep| code(ep.department_code_eval) }
        row(:unit_code_eval) { |ep| code(ep.unit_code_eval) }
        row(:started_at_eval) { |ep| code(ep.started_at_eval) }
      end
    end

    panel '單位資料' do
      table_for university.units do
        column(:code)
        column(:short_name)
        column(:name)
      end
    end

    panel '學院資料' do
      table_for university.colleges do
        column(:code)
        column(:short_name)
        column(:name)
      end
    end

    panel '系所資料' do
      table_for university.departments do
        column(:college)
        column(:code)
        column(:short_name)
        column(:name)
      end
    end
  end

  form do |f|
    f.inputs "基本資料" do
      f.input :code
      f.input :name
      f.input :short_name
    end

    # f.inputs "資料集" do

      # tabs do
        panel 'Email 辨識模型' do
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

        panel '單位資料' do
          f.has_many :units, allow_destroy: true, new_record: true do |unit|
            unit.input :code
            unit.input :short_name
            unit.input :name
          end
        end

        panel '學院資料' do
          f.has_many :colleges, allow_destroy: true, new_record: true do |college|
            college.input :code
            college.input :short_name
            college.input :name
          end
        end

        panel '系所資料' do
          f.has_many :departments, allow_destroy: true, new_record: true do |department|
            department.input :code
            department.input :college_code
            department.input :short_name
            department.input :name
          end
        end
    #   end
    # end

    f.actions
  end
end
