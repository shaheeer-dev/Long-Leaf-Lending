import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["starterScreen", "multiStepForm"]

  connect() {
    this.checkCurrentStep();
  }

  checkCurrentStep() {
    const currentStep = parseInt(localStorage.getItem('currentStep')) || 0;
    if (currentStep > 0) {
      this.hideStarterScreen();
    }
  }

  hideStarterScreen() {
    this.starterScreenTarget.classList.add('hidden');
    this.multiStepFormTarget.classList.remove('hidden');
  }
}
