require 'spec_helper'

describe QueueItemsController do
  let(:user) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  it "redirects user to root if not logged in" do
    get :index
    expect(response).to redirect_to root_path
  end

  context "user is logged in" do
    before { session[:user_id] = user.id } 

    describe "GET #index" do
      it "sets @queue_items to items of logged in user" do
        Fabricate(:queue_item, user: user)
        Fabricate(:queue_item, user: user)
        get :index
        expect(assigns(:queue_items)).to eq(user.queue_items)
      end

    end
    describe "POST #create" do
      it "sets @review to existing review for current user and video" do
        review = Fabricate(:review, creator: user, video: video)
        post :create, video_id: video.id
        expect(assigns(:review)).to eq(review)
      end

      it "sets @review to most recent review for current user" do
        review_old = Fabricate(:review, creator: user, video: video, created_at: 2.weeks.ago)
        review_new = Fabricate(:review, creator: user, video: video)
        post :create, video_id: video.id
        expect(assigns(:review)).to eq(review_new)
      end

      it "sets @queue_item" do
        post :create, video_id: video.id
        expect(assigns(:queue_item)).to be_instance_of(QueueItem)
      end

      context "queue_items saves successfully" do 
        before do
          post :create, video_id: video.id
        end

        it "shows successful flash message" do
          expect(flash[:success]).to_not be_nil
        end

        it "redirects to my_queue page" do
          expect(response).to redirect_to my_queue_path
        end
      end

      context "queue_item does not save successfully" do
        before do
          post :create
        end

        it "shows error flash message" do
          expect(flash[:error]).to_not be_nil
        end
        
        it "renders show video page" do
          expect(response).to render_template 'videos/show'
        end
      end
    end
  end
end
