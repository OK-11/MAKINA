<template>
  <div class="carousel3d-frame" id="carousel3d-frame">
    <div class="carousel3d_h">
      <h3>{{ missionName }}の小タスク</h3>
    </div>
    <carousel-3d :perspective="0" :space="200" :display="5" :controls-visible="true" :controls-prev-html="'&#10092;'" :controls-next-html="'&#10093;'" :controls-width="30" :controls-height="60" :clickable="true"　:start-index="currentSlide">
      <slide v-for="index in slides" :key="index" :index="index">
        <div :class="['task-item',{ 'task-open': taskStatus[index] === 1, 'task-close': taskStatus[index] === 2 }]">
          <h3>{{ taskNames[index] }}</h3>
          <div>作業者: {{ projectMissionTaskRoles[index] }}</div>
          <a :href="`/project_mission_tasks/${projectMissionTaskIds[index]}/comments`" class="btn">chat room</a>
        </div>
      </slide>
    </carousel-3d>
  </div>
</template>

<script>
import { Carousel3d, Slide } from 'vue-carousel-3d'

export default {
  components: {
    Carousel3d,
    Slide
  },
  props: {
    slides: {
      type: Array,
      required: true
    },
    taskNames: {
      type: Array,
      required: true
    },
    taskStatus: {
      type: Array,
      required: true
    },
    missionName: {
      type: String,
      required: true
    },
    currentSlide: {
      type: Number,
      required: true
    },
    projectMissionTaskIds: {
      type: Array,
      required: true
    },
    projectMissionTaskRoles: {
      type: Array,
      required: true
    }
  }
}
</script>
