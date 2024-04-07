ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def create_user_session(user = nil)
      post sign_in_path, params: { email: user.email, password: "topsecret" }
      follow_redirect!
    end

    def destry_user_session
      # @controller.send(:destroy_session)
    end
  end
end
