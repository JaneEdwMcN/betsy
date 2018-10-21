require "test_helper"

describe SessionsController do
 describe 'create' do
   let(:kit) { users(:kit) }

   it "logs in an exiting user and redirects to the root route" do
     expect {perform_login(kit)}.wont_change('User.count')

     must_redirect_to root_path
     expect(session[:user_id]).must_equal kit.id
   end

   # it "creates an account for a new user and redirects to the root route" do
   #    user = users(:kit)
   #    user.destroy
   #
   #    expect{perform_login(user)}.must_change('User.count', +1)
   #
   #    must_redirect_to root_path
   #    expect(session[:user_id]).wont_be_nil id
   #  end

   it "redirects to the login route if given invalid user data" do
  
   end
 end

end
