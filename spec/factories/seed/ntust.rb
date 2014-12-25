FactoryGirl.define do

  factory :university_ntust, parent: :university do
    code 'NTUST'
    name '國立臺灣科技大學'
    short_name '台科大'
    after(:create) do |ntust|
      ntust.email_patterns << create(:email_pattern_ntust_student)
      ntust.email_patterns << create(:email_pattern_ntust_staff)

      create(:college, {
        code: "1",
        name: "管理學院",
        short_name: "管院",
        university_code: "NTUST"
      })
      create(:college, {
        code: "2",
        name: "電資學院",
        short_name: "電資",
        university_code: "NTUST"
      })
      create(:college, {
        code: "3",
        name: "工程學院",
        short_name: "工程",
        university_code: "NTUST"
      })
      create(:college, {
        code: "4",
        name: "設計學院",
        short_name: "設計",
        university_code: "NTUST"
      })
      create(:college, {
        code: "5",
        name: "人社學院",
        short_name: "人社",
        university_code: "NTUST"
      })
      create(:college, {
        code: "6",
        name: "精誠學院",
        short_name: "精誠",
        university_code: "NTUST"
      })

      create(:department, {
        code: "01",
        name: "工業管理系",
        short_name: "工管系",
        university_code: "NTUST",
        college_code: "1"
      })
      create(:department, {
        code: "02",
        name: "電子工程系",
        short_name: "電子系",
        university_code: "NTUST",
        college_code: "2"
      })
      create(:department, {
        code: "03",
        name: "機械工程系",
        short_name: "機械系",
        university_code: "NTUST",
        college_code: "3"
      })
      create(:department, {
        code: "04",
        name: "材料科學與工程學系",
        short_name: "材料系",
        university_code: "NTUST",
        college_code: "3"
      })
      create(:department, {
        code: "05",
        name: "營建工程系",
        short_name: "營建系",
        university_code: "NTUST",
        college_code: "3"
      })
      create(:department, {
        code: "06",
        name: "化學工程系",
        short_name: "化工系",
        university_code: "NTUST",
        college_code: "3"
      })
      create(:department, {
        code: "07",
        name: "電機工程系",
        short_name: "電機系",
        university_code: "NTUST",
        college_code: "2"
      })
      create(:department, {
        code: "08",
        name: "企業管理系",
        short_name: "企管系",
        university_code: "NTUST",
        college_code: "1"
      })
      create(:department, {
        code: "09",
        name: "資訊管理系",
        short_name: "資管系",
        university_code: "NTUST",
        college_code: "1"
      })
      create(:department, {
        code: "10",
        name: "工商業設計系",
        short_name: "設計系",
        university_code: "NTUST",
        college_code: "4"
      })
      create(:department, {
        code: "11",
        name: "數位學習與教育研究所",
        short_name: "數位學習與教育研究所",
        university_code: "NTUST",
        college_code: "5"
      })
      create(:department, {
        code: "12",
        name: "自動化及控制研究所",
        short_name: "自動化及控制研究所",
        university_code: "NTUST",
        college_code: "3"
      })
      create(:department, {
        code: "13",
        name: "建築系",
        short_name: "建築系",
        university_code: "NTUST",
        college_code: "4"
      })
      create(:department, {
        code: "14",
        name: "材料科技研究所",
        short_name: "材料科技研究所",
        university_code: "NTUST",
        college_code: "3"
      })
      create(:department, {
        code: "15",
        name: "資訊工程系",
        short_name: "資工系",
        university_code: "NTUST",
        college_code: "2"
      })
      create(:department, {
        code: "16",
        name: "管理研究所",
        short_name: "管理研究所",
        university_code: "NTUST",
        college_code: "1"
      })
      create(:department, {
        code: "17",
        name: "應用外語系",
        short_name: "應外系",
        university_code: "NTUST",
        college_code: "5"
      })
      create(:department, {
        code: "18",
        name: "財務金融研究所",
        short_name: "財務金融研究所",
        university_code: "NTUST",
        college_code: "1"
      })
      create(:department, {
        code: "19",
        name: "光電工程研究所",
        short_name: "光電工程研究所",
        university_code: "NTUST",
        college_code: "2"
      })
      create(:department, {
        code: "20",
        name: "科技管理研究所",
        short_name: "科技管理研究所",
        university_code: "NTUST",
        college_code: "1"
      })
      create(:department, {
        code: "21",
        name: "管理學院 MBA",
        short_name: "管理學院 MBA",
        university_code: "NTUST",
        college_code: "1"
      })
      create(:department, {
        code: "22",
        name: "工程技術研究所",
        short_name: "工程技術研究所",
        university_code: "NTUST",
        college_code: "6"
      })
      create(:department, {
        code: "23",
        name: "醫學工程研究所",
        short_name: "醫學工程研究所",
        university_code: "NTUST",
        college_code: "6"
      })
      create(:department, {
        code: "24",
        name: "專利研究所",
        short_name: "專利研究所",
        university_code: "NTUST",
        college_code: "6"
      })
      create(:department, {
        code: "30",
        name: "不分系學士班",
        short_name: "不分系",
        university_code: "NTUST",
        college_code: "6"
      })
      create(:department, {
        code: "31",
        name: "工程學士班",
        short_name: "工程學士班",
        university_code: "NTUST",
        college_code: "3"
      })
      create(:department, {
        code: "32",
        name: "電資學士班",
        short_name: "電資學士班",
        university_code: "NTUST",
        college_code: "2"
      })
      create(:department, {
        code: "33",
        name: "管理學士班",
        short_name: "管理學士班",
        university_code: "NTUST",
        college_code: "1"
      })
      create(:department, {
        code: "34",
        name: "創意設計學士班",
        short_name: "創意設計學士班",
        university_code: "NTUST",
        college_code: "4"
      })
    end
  end

  factory :email_pattern_ntust_student, parent: :email_pattern do
    university nil
    university_code 'NTUST'
    priority 1
    identity Constant::USER_IDENTITY[:student]
    regexp '^(?<sid>(?<identity_detail>[aAbmdBMD])(?<started_at>\\d*)(?<department_code>\\d{2})\\d{3})@mail\\.ntust\\.edu\\.tw$'
    sid_eval "n.toLowerCase()"
    identity_detail_eval "switch (n.toLowerCase()) { case 'a': 'a'; break; case 'b': 'bachelor'; break; case 'm': 'master'; break; case 'd': 'doctor'; break; }"
    started_at_eval "new Date((parseInt(n)+1911) + '-9')"
  end

  factory :email_pattern_ntust_staff, parent: :email_pattern do
    university nil
    university_code 'NTUST'
    priority 2
    identity Constant::USER_IDENTITY[:staff]
    regexp '^(?<sid>.+)@mail\\.ntust\\.edu\\.tw$'
    sid_eval "n.toLowerCase()"
  end
end
