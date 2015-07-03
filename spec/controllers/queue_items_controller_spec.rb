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

      context "user is logged in" do

        let(:video) { Fabricate(:video) } 
        let(:user) { Fabricate(:user) } 

        before do
          session[:user_id] = user.id
        end

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

        it "associates queue item with current user" do
          post :create, video_id: video.id
          expect(QueueItem.first.user).to eq(user)
        end

        it "associates queue item with video" do
          post :create, video_id: video.id
          expect(QueueItem.first.video).to eq(video)
        end

        it "puts queue_item as last in the queue" do
          Fabricate(:queue_item, user: user, created_at: 2.weeks.ago)
          Fabricate(:queue_item, user: user, created_at: 2.weeks.ago)
          post :create, video_id: video.id
          last_item = QueueItem.find_by(video_id: video.id)
          expect(last_item.order).to eq(3)
        end

        it "will not add item to queue if it is already present" do
          Fabricate(:queue_item, user: user, video: video, created_at: 2.weeks.ago)
          post :create, video_id: video.id
          expect(user.queue_items.count).to eq(1)
        end

        it "creates a queue item in db" do
          post :create, video_id: video.id
          expect(QueueItem.count).to eq(1)
        end

        it "redirects to my_queue page" do
          post :create, video_id: video.id
          expect(response).to redirect_to my_queue_path
        end
      end
      #context "queue_item does not save successfully" do
        #before do
          #post :create
        #end

        #it "does not save to db" do
          #expect(QueueItem.count).to eq(0)
        #end

        #it "shows error flash message" do
          #expect(flash[:error]).to_not be_nil
        #end
        
        #it "renders show video page" do
          #expect(response).to render_template 'videos/show'
        #end

      end
    end
end
