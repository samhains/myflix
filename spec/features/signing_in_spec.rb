require 'spec_helper'

feature "Signing In" do
  scenario "signing in with correct details" do
    alice = Fabricate(:user)
    sign_in alice
  end
end
