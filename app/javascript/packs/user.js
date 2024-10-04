export function polling_mission(){
  const mission_squares = document.getElementsByClassName("mission_square");
  fetch('/api/polling_mission')
    .then(response => response.json())
    .then(data => {
      for(let i=0; i<data.length; i++){
        if(data[i].status == 1){
          mission_squares[i].classList.remove("mission_square_close");
          mission_squares[i].classList.add("mission_square_opne");
        }else{
          mission_squares[i].classList.remove("mission_square_opne");
          mission_squares[i].classList.add("mission_square_close");
        }
      }
      setTimeout(polling_mission, 10000)
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
      setTimeout(polling_task, 10000)
    })
    .catch(error => console.error('Polling error:', error))
}


