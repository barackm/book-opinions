import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["followersBtn", "followingBtn", "following", "followers"];

  connect() {
    const following = document.querySelector(".following-show");
    const followers = document.querySelector(".followers-show");
    this.followersBtnTarget.classList.remove("active");
    following.classList.add("active");
    followers.classList.remove("active");

    this.followersTarget.classList.remove("active");
  }

  showFollowers() {
    const following = document.querySelector(".following-show");
    const followers = document.querySelector(".followers-show");
    this.followersBtnTarget.classList.add("active");
    this.followingBtnTarget.classList.remove("active");
    following.classList.remove("active");
    followers.classList.add("active");
  }

  showFollowing() {
    const following = document.querySelector(".following-show");
    const followers = document.querySelector(".followers-show");
    this.followersBtnTarget.classList.remove("active");
    this.followingBtnTarget.classList.add("active");
    following.classList.add("active");
    followers.classList.remove("active");
  }
}
