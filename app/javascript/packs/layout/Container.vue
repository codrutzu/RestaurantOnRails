<template lang="pug">
  v-content
    router-view
</template>

<script>
export default {
  name: 'Container',

  computed: {
    activeRouteName() {
      return this.$route.name;
    }
  }
}
</script>

<style>
/*
.v-content {
  background-color: #f5efefd0;
} */

</style>