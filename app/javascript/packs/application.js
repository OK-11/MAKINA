// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import { project_mission_set } from "./project_mission";
import { project_mission_task_set } from "./project_mission_task";
import { polling_mission, polling_task, user_nav_button, admin_user_btn, user_notice } from "./user";

Rails.start()
Turbolinks.start()
ActiveStorage.start()





document.addEventListener('turbolinks:load', function() {
  user_notice();
  if (window.location.pathname.includes("/admin/")) {
    if (window.location.pathname.includes("/project_mission_tasks/new")) {
      project_mission_task_set();
    }else if (window.location.pathname.includes("/project_missions/new")) {
      project_mission_set();
    }else if (window.location.pathname.includes("users") && /\/users\/.+/.test(window.location.pathname) === false) {
      admin_user_btn();
    }
  }else if (window.location.pathname.includes("/users")) {
    polling_mission();
    user_nav_button();
  }else if (window.location.pathname.includes("/project_missions")) {
    polling_task();
    user_nav_button();
  }else if (window.location.pathname.includes("/comments")) {
    user_nav_button();
  }
});














