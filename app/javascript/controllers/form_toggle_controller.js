import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["starterScreen", "multiStepForm", "startButton"]

  connect() {
    this.startButtonTarget.addEventListener('click', this.showForm.bind(this))
  }

  showForm() {
    this.starterScreenTarget.classList.add('hidden')
    this.multiStepFormTarget.classList.remove('hidden')
  }
}
