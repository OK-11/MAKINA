import Vue from 'vue';
import Carousel3d from '../Carousel3d.vue';


export function polling_mission(){
  const mission_squares = document.getElementsByClassName("mission_square");
  fetch('/api/polling_mission')
    .then(response => response.json())
    .then(data => {
      for(let i=0; i<data.project_missions.length; i++){
        if(data.project_missions[i].status === 1){
          mission_squares[i].classList.remove("mission_square_close");
          mission_squares[i].classList.add("mission_square_opne");
        }else{
          mission_squares[i].classList.remove("mission_square_opne");
          mission_squares[i].classList.add("mission_square_close");
        }
      }

      let slides_array = [];
      let taskName_array = [];
      let taskStatus_array = [];
      for(let i=0; i<data.project_mission_tasks.length; i++){
        slides_array[slides_array.length] = i;
        taskName_array[taskName_array.length] = data.tasks[i]
        taskStatus_array[taskStatus_array.length] = data.project_mission_tasks[i].status
      }
      const carousel3dFrame = document.getElementById('carousel3d-frame')
      if (carousel3dFrame) {
        new Vue({
          render: h => h(Carousel3d, {

            props: {
              slides: slides_array,
              taskNames: taskName_array,
              taskStatus: taskStatus_array,
              missionName: data.mission_name,
              currentSlide: data.current_slide
            }
          })
        }).$mount(carousel3dFrame)
      }
      const task_items = document.getElementsByClassName("task-item");
      for(let i=0; i<data.project_mission_tasks.length; i++){
        if(data.project_mission_tasks[i].status === 1){
          task_items[i].classList.remove("task-close");
          task_items[i].classList.add("task-open");
        }else{
          task_items[i].classList.remove("task-open");
          task_items[i].classList.add("task-close");
        }
      }
      setTimeout(polling_mission, 20000)
    })
    .catch(error => console.error('Polling error:', error))
}

export function polling_task(){
  const id = window.location.pathname.split("/")[2];
  const task_squares = document.getElementsByClassName("task_square");
  fetch(`/api/polling_task/${id}`)
    .then(response => response.json())
    .then(data => {
      for(let i=0; i<data.length; i++){
        if(data[i].status == 1){
          task_squares[i].classList.remove("task_square_close");
          task_squares[i].classList.add("task_square_opne");
        }else{
          task_squares[i].classList.remove("task_square_opne");
          task_squares[i].classList.add("task_square_close");
        }
      }
      setTimeout(polling_task, 20000)
    })
    .catch(error => console.error('Polling error:', error))
}


export function user_nav_button(){
  const user_nav_btn = document.getElementById("user_nav_btn");
  user_nav_btn.addEventListener("click", function() {
    const user_nav = document.getElementById("user_nav");
    user_nav.classList.remove("user_nav_close");
    user_nav.classList.add("user_nav");
  });

  const user_nav_close_btn = document.getElementById("user_nav_close_btn");
  user_nav_close_btn.addEventListener("click", function() {
    const user_nav = document.getElementById("user_nav");
    user_nav.classList.remove("user_nav");
    user_nav.classList.add("user_nav_close");
  })
}







export function admin_user_btn(){
  const userBtns = document.getElementsByClassName("user-btn");
  const userEditTr = document.getElementsByClassName("user_edit_tr");

  for(let i=0; i<userBtns.length; i++){
    userBtns[i].addEventListener("click", function() {
      userEditTr[i].classList.toggle("user_edit_tr_close");
    });
  }

  const userTypeUserBtn = document.getElementById("user_type_user_btn");
  const userTypeWorkerBtn = document.getElementById("user_type_worker_btn");
  const userTypeAdminBtn = document.getElementById("user_type_admin_btn");
  const userTypeUser = document.getElementById("user_type_user");
  const userTypeWorker = document.getElementById("user_type_worker");
  const userTypeAdmin = document.getElementById("user_type_admin");

  userTypeUserBtn.addEventListener("click", function() {
    userTypeWorker.classList.remove("user_type_open");
    userTypeAdmin.classList.remove("user_type_open");
    userTypeUser.classList.add("user_type_open");
  })
  userTypeWorkerBtn.addEventListener("click", function() {
    userTypeUser.classList.remove("user_type_open");
    userTypeAdmin.classList.remove("user_type_open");
    userTypeWorker.classList.add("user_type_open");
  })
  userTypeAdminBtn.addEventListener("click", function() {
    userTypeUser.classList.remove("user_type_open");
    userTypeWorker.classList.remove("user_type_open");
    userTypeAdmin.classList.add("user_type_open");
  })
}


