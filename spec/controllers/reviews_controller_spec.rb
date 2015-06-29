require 'spec_helper'

describe ReviewsController do
  describe "POST #create" do
    let(:video){ Fabricate(:video) }
    let(:user){ Fabricate(:user) }
    
    it "redirects to root if not logged in" do
      post :create, id: video.id
      expect(response).to redirect_to root_path
    end

    it "creates @review if user is logged in" do
      session[:user_id] = user.id
      post :create, id: video.id, review: {rating: 5}
      expect(assigns(:review)).to be_instance_of(Review)
    end

    it "creates @video if user is logged in" do
      session[:user_id] = user.id
      post :create, id: video.id, review: {rating: 5}
      expect(assigns(:video)).to be_instance_of(Video)
    end
      
    context "if save is successful" do
      before do
        session[:user_id] = user.id
        post :create, id: video.id, review: { rating: 5, description: "Great video!" }
      end

      it "displays successful flash notice" do
        expect(flash[:success]).to_not be_blank
      end

      it "redirects to video path" do
        expect(response).to redirect_to video_path
      end
    end

    context "if save is unsuccessful" do
      before do
        session[:user_id] = user.id
        post :create, id: video.id, review: { rating: 5}
      end

      it "displays unsuccessful flash notice" do
        expect(flash[:danger]).to_not be_blank
      end

      it "renders the video show page" do
        expect(response).to render_template 'videos/show'
      end
    end

  end
end
