// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"
import multiStepFormController from "./multi_step_form_controller"
import formToggleController from "./form_toggle_controller"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

application.register("multi-step-form", multiStepFormController)
application.register("form-toggle", formToggleController)
