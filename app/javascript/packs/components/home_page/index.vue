<template lang="pug">
  .plates
    HeroSection
</template>

<script>

import HeroSection from './HeroSection'
import DummyComp from './Dummy'

export default {

  name: 'PlatesIndex',
  components: {   HeroSection,
                  DummyComp
              }
}

</script>