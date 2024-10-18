export function project_mission_set(){
  let mission_orders = [];
  const mission_order_field_id = document.getElementById("mission_order_field_id");
  const mission_check_boxs = document.getElementsByClassName("mission_check_box");
  const mission_label_orders = document.getElementsByClassName("mission_label_order");
  for(let i=0; i<mission_check_boxs.length; i++){
    mission_check_boxs[i].addEventListener("change", function() {
      if (mission_check_boxs[i].checked == true) {
        mission_orders.push(mission_check_boxs[i].value);
        mission_order_field_id.value = mission_orders.join(",");
        mission_label_orders[i].innerHTML = mission_orders.indexOf(mission_check_boxs[i].value) + 1;
      }else{
        mission_orders.splice(mission_orders.indexOf(mission_check_boxs[i].value), 1);
        mission_order_field_id.value = mission_orders.join(",");
        mission_label_orders[i].innerHTML = "";
        for(let j=0; j<mission_check_boxs.length; j++) {
          if (mission_check_boxs[j].checked == true){
            mission_label_orders[j].innerHTML = mission_orders.indexOf(mission_check_boxs[j].value) + 1;
          }
        }
      }
    });
  }
}