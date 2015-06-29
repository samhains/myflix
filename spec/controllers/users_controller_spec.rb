require 'spec_helper'

describe UsersController do
  describe "GET #new" do
    it "creates new @user if user unauthenticated" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end

  end
  
  describe "POST #create" do

    it "creates @user" do
       post :create, :user => { name: "Sam" }
       expect(assigns(:user)).to be_instance_of(User)
    end

    context "user authenticated" do
      before do
         post :create, :user =>  Fabricate.attributes_for(:user) 
      end

      it "creates user in database" do
        expect(User.count).to eq(1)
      end

      it "redirect to login_path if authentication succeeds " do
         expect(response).to redirect_to login_path
      end
    end

    context "user creation fails" do
      before { post :create, :user => { name: "Sam" } } 

      it "render sign up form" do
         expect(response).to render_template('users/new')
      end
      
      it "does not create user" do
        expect(User.count).to eq(0)
      end
    end 

  end
end
