RSpec.describe "Signing in", js: true do
  describe "the signin process", :type => :feature do
    before :each do
      User.make(email: 'user@example.com', password: '123456', first_name: "user", last_name: "user")
    end

    it "signs me in" do
      visit '/'
      within("#session") do
        fill_in 'sessions_email', with: 'user@example.com'
        fill_in 'sessions_password', with: '123456'
      end
      click_button 'normal_sign_in'
      expect(page).to have_content 'Hello'
    end
  end
end
