require 'spec_helper'

describe VideosController do
  
  describe "GET #show" do
    context "user is authenticated" do
      let(:video){ Fabricate(:video) }
      let (:first_review){ Fabricate(:review, video: video)}
      let (:second_review){ Fabricate(:review, video: video)}

      before do 
        user = Fabricate(:user)
        session[:user_id] = user.id
        get :show, id: video.id
      end

      it "sets @video" do
        expect(assigns(:video)).to eq(video)
      end

      it "sets @review" do
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it "sets @reviews" do
        expect(assigns(:reviews)).to  include(second_review, first_review)
      end
    end 

    it "redirects to root path if user not authenticated" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end
  end

  describe "GET #search" do
    it "sets the video instance variable" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      south_park = Fabricate(:video, title: "South Park")
      get :search, title: "S"
      expect(assigns(:videos)).to eq([south_park])
    end

   it "renders to root path if user not authenticated" do
      video = Fabricate(:video)
      get :search, id: video.id
      expect(response).to redirect_to root_path
      
    end
  end
end
