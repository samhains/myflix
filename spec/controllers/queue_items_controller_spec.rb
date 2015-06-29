require 'spec_helper'

describe QueueItemsController do
  let(:user) { Fabricate(:user) }

  it "redirects user to root if not logged in" do
    get :index
    expect(response).to redirect_to root_path
  end

  context "user is logged in" do
    before do
      session[:user_id] = user.id
    end

    describe "GET #index" do
      it "sets @queue_items to items of logged in user" do
        Fabricate(:queue_item, user: user)
        Fabricate(:queue_item, user: user)
        get :index
        expect(assigns(:queue_items)).to eq(user.queue_items)
      end

    end
  end
end
