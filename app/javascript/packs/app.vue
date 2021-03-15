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

import { mapActions } from 'vuex'

export default {
  name: 'App',
  components: { Header, Container, Footer },

  created() {
    this.getCurrentUser();
  },

  mounted() {
    console.log("App")
  },

  methods: {
    ...mapActions({
      getCurrentUser: 'currentUser'
    })
  }
};
</script>

<style>

.v-toaster {
  margin-top: 50px;
  margin-right: 20px;
}

.v-toast {
  width: 300px;
}

</style>