RSpec.shared_context "login to admin panel" do
  before :each do
    @admin_credentials = {username: 'test_admin', password: 'password'}
    @admin = create(:admin, @admin_credentials)
    login_as @admin, scope: :admin
  end
end
