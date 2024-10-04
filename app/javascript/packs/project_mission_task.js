export function project_mission_task_set(){
  let task_positions = [];
  const task_position_field_id = document.getElementById("task_position_field_id");
  const task_check_boxs = document.getElementsByClassName("task_check_box");
  const task_label_positions = document.getElementsByClassName("task_label_position");
  for(let i=0; i<task_check_boxs.length; i++){
    task_check_boxs[i].addEventListener("change", function() {
      if (task_check_boxs[i].checked == true) {
        task_positions.push(task_check_boxs[i].value);
        task_position_field_id.value = task_positions.join(",");
        task_label_positions[i].innerHTML = task_positions.indexOf(task_check_boxs[i].value) + 1;
        console.log(task_positions);
      }else{
        task_positions.splice(task_positions.indexOf(task_check_boxs[i].value), 1);
        task_position_field_id.value = task_positions.join(",");
        task_label_positions[i].innerHTML = "";
        for(let j=0; j<task_check_boxs.length; j++) {
          if (task_check_boxs[j].checked == true){
            task_label_positions[j].innerHTML = task_positions.indexOf(task_check_boxs[j].value) + 1;
          }
        }
        console.log(task_positions);
      }
    });
  }
}