<template lang="pug">
  v-content(class="contentBackground")
    router-view
</template>

<script>
export default {
  name: 'Container'
}
</script>

<style>
  .v-content {
    padding-top: 6em !important;
  }
</style>