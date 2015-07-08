require 'spec_helper'

describe QueueItemsController do
  let(:user) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  it "redirects user to root if not logged in" do
    get :index
    expect(response).to redirect_to root_path
  end

  context "user is logged in" do

    before { set_current_user } 

    describe "GET #index" do
      it "sets @queue_items to items of logged in user" do
        Fabricate(:queue_item, user: user)
        Fabricate(:queue_item, user: user)
        get :index
        expect(assigns(:queue_items)).to eq(user.queue_items)
      end

    end

    describe "POST #create" do

        it "associates queue item with most recent rating for current user" do
          review_old = Fabricate(:review, creator: user, video: video, created_at: 2.weeks.ago)
          review_new = Fabricate(:review, creator: user, video: video, created_at: 1.day.ago)
          post :create, video_id: video.id
          expect(QueueItem.first.rating).to eq(review_new.rating)
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

    describe "DELETE #destroy" do
      it "removes the queue item from the database" do
        queue_item = Fabricate(:queue_item, user: user)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end

      it "should not delete item if it is not in the users queue" do
        new_user = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: new_user)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(1)
      end

      it "normalizes the remaining queue items" do
        queue_item1 = Fabricate(:queue_item, user: user, order:1)
        queue_item2 = Fabricate(:queue_item, user: user, order:2)
        delete :destroy, id: queue_item1.id
        expect(queue_item2.reload.order).to eq(1)
      end

      it "redirects to my queue path" do
        queue_item = Fabricate(:queue_item, user: user)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
    end
    describe "POST #update_queue" do

      it "creates review if one does not already exist on queue item" do
        queue_item1 = Fabricate(:queue_item, order:1, user:user)
        post :update_queue, queue_items: 
          [{ id: queue_item1.id, 
            order:1, 
            rating: 2 }]
        expect(queue_item1.reload.rating).to eq(2)
      end

      it "updates existing review score" do
        review = Fabricate(:review, rating:1, creator: user)
        video2 = Fabricate(:video, reviews: [review])
        queue_item1 = Fabricate(:queue_item, video: video2, user: user)

        post :update_queue, queue_items: 
          [{ id: queue_item1.id, 
            order:1, 
            rating: 2 }]
        expect(queue_item1.reload.rating).to eq(2)
      end

      it "redirects to my_queue_path" do
        queue_item1 = Fabricate(:queue_item, order:1)
        queue_item2 = Fabricate(:queue_item, order:2) 
        post :update_queue, queue_items: 
          [{ id: queue_item1.id, order:2 },
          { id: queue_item2.id, order:1 }]
        expect(response).to redirect_to my_queue_path

      end
      it "updates the order of a single queue_item" do
        queue_item1 = Fabricate(:queue_item, order:1, user: user)
        queue_item2 = Fabricate(:queue_item, order:2, user: user) 
        post :update_queue, queue_items: 
          [{ id: queue_item1.id, order:2 },
          { id: queue_item2.id, order:1 }]
        expect(user.queue_items).to eq([queue_item2, queue_item1])
      end

      it "reorders list without first item" do
        queue_item1 = Fabricate(:queue_item, order:1, user:user)
        queue_item2 = Fabricate(:queue_item, order:2, user:user) 
        post :update_queue, queue_items: 
          [{ id: queue_item1.id, order:3 },
          { id: queue_item2.id, order:2 }]
        expect(user.queue_items).to eq([queue_item2, queue_item1])
      end

      it "maintains order if nothing changed" do
        queue_item1 = Fabricate(:queue_item, order:1, user:user)
        queue_item2 = Fabricate(:queue_item, order:2, user:user) 
        post :update_queue, queue_items: 
          [{ id: queue_item1.id, order:1 },
          { id: queue_item2.id, order:2 }]
        expect(user.queue_items).to eq([queue_item1, queue_item2])

      end

      it "enforces natural ordering starting at 1" do
        queue_item1 = Fabricate(:queue_item, order:1, user:user)
        queue_item2 = Fabricate(:queue_item, order:2, user:user) 
        post :update_queue, queue_items: 
          [{ id: queue_item1.id, order:1 },
          { id: queue_item2.id, order:3 }]
        expect(user.queue_items.map(&:order)).to eq([1,2])
      end

      it "shows flash error if input is invalid" do

        queue_item1 = Fabricate(:queue_item, order:1, user:user)
        queue_item2 = Fabricate(:queue_item, order:2, user:user) 
        post :update_queue, queue_items: 
          [{ id: queue_item1.id, order:2 },
          { id: queue_item2.id, order:'hello' }]
        expect(flash[:danger]).to_not be_nil
      end

      it "does not reorder items if input is invalid" do
        queue_item1 = Fabricate(:queue_item, order:1, user:user)
        queue_item2 = Fabricate(:queue_item, order:2, user:user) 
        post :update_queue, queue_items: 
          [{ id: queue_item1.id, order:2 },
          { id: queue_item2.id, order:'hello' }]
        expect(queue_item1.reload.order).to eq(1)

      end

      it "does not reorder items if they arent current_users" do
        user2 = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, order:1, user:user2)
        queue_item2 = Fabricate(:queue_item, order:2, user:user) 
        post :update_queue, queue_items: 
          [{ id: queue_item1.id, order:2 },
          { id: queue_item2.id, order:1 }]
        expect(queue_item1.reload.order).to eq(1)

      end
    end
  end
end
