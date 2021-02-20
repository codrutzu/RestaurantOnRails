<template lang="pug">
  v-app
    Header
    Container
    Footer
    //- HeroSection
</template>

<script>

import Header from './layout/Header'
import Container from './layout/Container'
import Footer from './layout/Footer'

export default {
  name: 'App',
  components: { Header, Container, Footer }
};
</script>
