import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["step", "error", "input"]

  connect() {
    this.showCurrentStep();
    this.inputTargets.forEach(input => {
      input.addEventListener('input', this.clearError.bind(this));
    });
  }

  showCurrentStep() {
    this.stepTargets.forEach((element, index) => {
      element.classList.toggle('hidden', index !== this.currentStep);
    });
  }

  nextStep(event) {
    event.preventDefault();
    const currentStepElement = this.stepTargets[this.currentStep];
    const requiredFields = currentStepElement.querySelectorAll("[required]");

    let allValid = true;
    requiredFields.forEach(field => {
      if (!field.value.trim()) {
        allValid = false;
        const errorElement = field.nextElementSibling;
        if (errorElement && errorElement.classList.contains("error-message")) {
          errorElement.classList.remove("hidden");
        }
      }
    });

    if (allValid) {
      if (this.currentStep < this.stepTargets.length - 1) {
        this.currentStep++;
        this.showCurrentStep();
      } else {
        const form = this.element.querySelector("form");
        form.submit();
      }
    }
  }

  previousStep(event) {
    event.preventDefault();
    if (this.currentStep > 0) {
      this.currentStep--;
      this.showCurrentStep();
    }
  }

  clearError(event) {
    const errorElement = event.target.nextElementSibling;
    if (errorElement && errorElement.classList.contains("error-message")) {
      errorElement.classList.add("hidden");
    }
  }

  get currentStep() {
    return parseInt(this.data.get("currentStep") || 0);
  }

  set currentStep(value) {
    this.data.set("currentStep", value);
  }
}
