import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["close", "flash"];

  closeAlert() {
    this.flashTarget.classList.add("close");
  }
}
