<template lang="pug">
  .homepage
    HeroSection
    PlatesComponent
</template>

<script>

import HeroSection from './HeroSection'
import PlatesComponent from './PlatesComponent'

export default {

  name: 'HomePage',
  components: {   HeroSection, PlatesComponent  }
}

</script>

<style>

* {
  font-family: 'Montserrat';
}

</style>