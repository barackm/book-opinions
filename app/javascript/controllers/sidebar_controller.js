import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["profile", "home"];

  connect() {
    const route = window.location.pathname.includes("users");
    if (route) {
      this.profileTarget.classList.add("active");
      this.homeTarget.classList.remove("active");
    } else {
      this.profileTarget.classList.remove("active");
      this.homeTarget.classList.add("active");
    }
  }
}
