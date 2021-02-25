<template lang="pug">
  .navigation(v-if="currentUser != null")
    v-app-bar(
      fixed
      flat
      prominent
      shrink-on-scroll
      :class="bg"
    )
      v-img(
        :src="require('../images/eureka-logo.png')"
        max-height="40"
        max-width="40"
        contain
      )

      v-spacer

      .navigation-items
        v-btn.navItem(
          text
          key="HOME"
          to="/home"

        )
          span(
            class="menu-item"
          ) HOME


        v-btn.navItem(
          v-if="loggedIn() === true"
          text
          key="CART"
          to="/cart"
        )
          v-badge(
            bordered
            color="red"
            overlap
            right
            :content="currentUser.items_count"
          )
            span(
              class="menu-item"
            ) CART

        v-btn.navItem(
          v-else
          text
          key="CART"
          to="/login"
          disabled=true
        )
          span(
            class="menu-item-disabled"
          ) CART


        v-btn.navItem(
          v-if="loggedIn()"
          text
          :key="currentUser.id"
        )
          span(
            class="menu-item"
          ) {{ currentUser.name }}

        v-btn.navItem(
          v-else
          text
          key="ACCOUNT"
        )
          span(
            class="menu-item"
          ) LOG IN




</template>


<script>

import { mapGetters } from 'vuex'

export default {
  name: 'Header',
  data() {
    return {
      bg: 'notScrolled',
      userName: ''
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
    },

    routeRedirect() {
      console.log("test")
      window.location.href = window.location.origin + '/cart'
    },

    loggedIn() {
      return (this.currentUser != null && this.currentUser != "noUser")
    }
  },


  computed: {
    ...mapGetters({
      currentUser: 'currentUser'
    }),

    activeRouteName() {
      return this.$route.name;
    }
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
  box-shadow: 0 3px 5px -2px gray !important;
}

.v-active--point {
  background-color: #fa357b;
  border-radius: 100%;
  width: 6px;
  height: 6px;
  position: absolute;
  left: -20%;
}

.navItem {
  position: relative;
  padding: 1em;
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