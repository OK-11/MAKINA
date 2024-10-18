<template>
  <div class="user_notice" id="user_notice">
    <div class="notice_square" v-for="index in indexs" :key="index">
      <p>{{ from_user_names[index] }}さんから新着メッセージ</p>
      <p>{{ mission_names[index] }} >>> {{ task_names[index] }}</p>
      <a :href="`/notice/update/${notice_ids[index]}`" class="btn">確認</a>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    indexs: {
      type: Array,
      required: true
    },
    from_user_names: {
      type: Array,
      required: true
    },
    mission_names: {
      type: Array,
      required: true
    },
    task_names: {
      type: Array,
      required: true
    },
    notice_ids: {
      type: Array,
      required: true
    }
  }
}
</script>