<template lang="pug">
  .navigation
    v-app-bar(
      flat
      fixed
      prominent
      shrink-on-scroll
      :class="bg"
    )
      v-img(
        :src="require('../images/eureka-logo.svg')"
        max-height="40"
        max-width="40"
        contain
      )

      v-spacer

      .navigation-items
        v-btn(
          text
          v-for='item in navbarItems'
          :key='item.title'
          :to='{ name: item.name}'
        )

          span(
            class="menu-item"
          ) {{ item.title }}

        span {{ currentUser }}

</template>


<script>

import { mapGetters } from 'vuex'

export default {
  name: 'Header',
  data() {
    return {
      bg: 'notScrolled',
      navbarItems: [
        { title: 'MENU', name: 'plates_index_path' },
        { title: 'ACCOUNT', name: 'account_index_path' },
        { title: 'CART', name: 'cart_path' }
      ]
    }
  },

  mounted() {
    window.onscroll = () => {
      this.changeColor();
    };
    console.log("Header")
  },

  methods: {
    changeColor() {
      if (
        document.body.scrollTop > 50 ||
        document.documentElement.scrollTop > 50
      ) {
        this.bg = 'scrolledNav';
      } else {
        this.bg = 'notScrolled';
      }
    }
  },

  computed: {
    ...mapGetters({
      currentUser: 'currentUser'
    })
  }
}
</script>

<style>
.theme--light.v-btn {
  color: transparent;
}

.v-image {
  margin-left: 5em;
}

.v-toolbar--prominent {
  align-items: center !important;
}

.scrolledNav {
  background-color: white !important;

  transition: 1s;
  box-shadow: 0 2px 4px 0 rgba(0,0,0,.2);
}

.notScrolled {
  background-color: transparent !important;
  transition: 1s;
  height: 80px;
}

.navigation-items {
  margin-right: 5em;
}

.v-toolbar--prominent .v-toolbar__content {
  align-items: center;
}

</style>