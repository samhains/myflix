require 'spec_helper'

describe ReviewsController do
  describe "POST #create" do
    let(:video){ Fabricate(:video) }
    let(:user){ Fabricate(:user) }

    it_behaves_like "requires sign in" do
      let(:action) { post :create, id: video.id }
    end
    
    context "user is logged in" do
      before do
        session[:user_id] = user.id
      end
        
      it "creates @review" do
        post :create, id: video.id, review: { rating: 5 }
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it "associates review with current_user" do
        post :create, id: video.id, review: { rating:  5}
        expect(assigns(:review).creator).to eq(user)
      end

      it "associates review with video" do
        post :create, id: video.id, review: { rating:  5}
        expect(assigns(:review).video).to eq(video)
      end

      it "creates @video" do
        post :create, id: video.id, review: { rating:  5}
        expect(assigns(:video)).to be_instance_of(Video)
      end
        
      context "if validation is successful" do
        before do
          post :create, id: video.id, review: { rating: 5, description: "Great video!" }
        end

        it "displays successful flash notice" do
          expect(flash[:success]).to_not be_blank
        end

        it "redirects to video path" do
          expect(response).to redirect_to video_path
        end
      end

      context "if validation is unsuccessful" do
        before do
          post :create, id: video.id, review: { rating: 5}
        end

        it "creates @video" do
          expect(assigns(:video)).to be_instance_of(Video)
        end

        it "creates @review" do
          expect(assigns(:review)).to be_instance_of(Review)
        end

        it "should not create a review" do
          expect(Review.count).to eq(0)
        end

        it "displays unsuccessful flash notice" do
          expect(flash[:danger]).to_not be_blank
        end

        it "renders the video show page" do
          expect(response).to render_template 'videos/show'
        end

        it "creates @reviews" do
          review = Fabricate(:review,video: video)
          expect(assigns(:reviews)).to eq([review])
        end
      end
    end
  end
end
