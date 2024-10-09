import Vue from 'vue';
import Carousel3d from '../Carousel3d.vue';

export function carousel3d() {
  fetch('/api/carousel_mission')
    .then(response => response.json())
    .then(data => {
      let slides_array = [];
      let taskName_array = [];
      for(let i=0; i<data.project_mission_tasks.length; i++){
        slides_array[slides_array.length] = i;
        taskName_array[taskName_array.length] = data.tasks[i];
      }
      const carousel3dPosition = document.getElementById('carousel3d_position')
      if (carousel3dPosition) {
        new Vue({
          render: h => h(Carousel3d, {

            props: {
              slides: slides_array,
              taskNames: taskName_array
            }

          })
        }).$mount(carousel3dPosition)
      }
    })
    .catch(error => console.error('Polling error:', error))
} 
