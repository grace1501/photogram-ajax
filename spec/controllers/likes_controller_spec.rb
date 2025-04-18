require "rails_helper"

RSpec.describe LikesController, type: :controller do
  render_views

  describe "create" do
    it "responds to js requests with js", points: 1 do
      owner = User.create(
        username: "test",
        email: "test@example.com",
        password: "password",
        avatar_image: "https://robohash.org/test.png"
      )

      fan = User.create(
        username: "fan",
        email: "fan@example.com",
        password: "password",
        avatar_image: "https://robohash.org/fan.png"
      )

      photo = Photo.create(
        caption: "hi there :3",
        image: "https://robohash.org/photo.png",
        owner: owner
      )

      sign_in fan

      params = { like: { fan_id: fan.id, photo_id: photo.id } }

      post :create, params: params, as: :js

      expect(response.media_type).to eq Mime[:js]
      expect(response.body).not_to be_blank
    end
  end

  describe "destroy" do
    it "responds to js requests with js", points: 1 do
      owner = User.create(
        username: "test",
        email: "test@example.com",
        password: "password",
        avatar_image: "https://robohash.org/test.png"
      )

      fan = User.create(
        username: "fan",
        email: "fan@example.com",
        password: "password",
        avatar_image: "https://robohash.org/fan.png"
      )

      photo = Photo.create(
        caption: "hi there :3",
        image: "https://robohash.org/photo.png",
        owner: owner
      )

      like = Like.create(photo: photo, fan: fan)

      sign_in fan

      delete :destroy, params: { id: like.id }, as: :js

      expect(response.media_type).to eq Mime[:js]
      expect(response.body).not_to be_blank
    end
  end
end
