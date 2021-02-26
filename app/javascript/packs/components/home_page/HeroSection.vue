<template lang="pug">
  .section-wrapper
    section.hero-section
      h1.discover
        | explore
        .page-scroll-indicator(v-on:click="scrollToPlates()")
          .page-scroll-wheel
    .bottom-anchor
</template>

<script>
export default {
  name: 'HeroSection',

  methods: {
  scrollToPlates() {
      const el = this.$el.getElementsByClassName('bottom-anchor')[0];

      if (el) {
        el.scrollIntoView({behavior: 'smooth'});
      }
  }
  },
}
</script>

<style>


</style>