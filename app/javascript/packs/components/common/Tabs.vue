<template lang="pug">
  .tabs
    .tab-links(class="mt-12")
      template(v-for="tab in tabLinks")
        v-flex
          router-link.tab-link(
            :to="{ name: tab.link }"
          ) {{ tab.name }}
</template>

<script>
export default {
  name: 'Tabs',

  props: {
    tabLinks: {
      type: Array,
      default: () => []
    }
  }
}
</script>

<style scoped>

.tab-link {
  border: 1px solid transparent;
  border-radius: 20px;
}

.tabs {
  max-width: 700px;
  margin: auto
}

.v-application a {
  display: block;
  font-weight: 500;
  font-size: 16px;
  color: #581515;
}

.tab-links {
  display: flex;
  border: 1px solid rgba(26,26,26, 0.2);
  border-radius: 20px;
}

.router-link-exact-active {
  background-color: #581515;
  color: white !important;
}

</style>