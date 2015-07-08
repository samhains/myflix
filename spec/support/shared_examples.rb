shared_examples "requires sign in" do
  it "directs to the root page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to root_path
  end
end
