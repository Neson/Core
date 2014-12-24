require "factory_girl"

namespace :dev do
  desc "Seed data for development environment"
  task prime: "db:setup" do
    include FactoryGirl::Syntax::Methods

    if Rails.env.development?

      create(:university, :ntust)

      # create(:user, email: "user@example.com", password: "password")
    end
  end
end
