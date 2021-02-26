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

.hero-section {
  background-image: url('../../images/hero-banner.png');
  height: 100vh;
  background-size: cover;
  display: flex;
  align-items: flex-end;
  padding-bottom: 5%;
}

.discover {
  display: flex;
  color: white;
  font-family: 'Montserrat';
  top: 500px;
  padding-left:  7rem;
  font-weight: 600;
}


.page-scroll-indicator {
   margin-left: 40px;
   width: 30px;
   height: 50px;
   border: 3px solid white;
   border-radius: 15px;
   cursor: pointer;
   position: relative;
   text-align: center;
}

.page-scroll-wheel {
  height: 6px;
  margin: 2px auto 0;
  display: block;
  width: 3px;
  background-color: white;
  border-radius: 50%;
  -webkit-animation: 1.6s ease infinite wheel-up-down;
 -moz-animation: 1.6s ease infinite wheel-up-down;
  animation: 1.6s ease infinite wheel-up-down;
}


.bottom-anchor {
  padding-bottom: 0;
}

@-webkit-keyframes wheel-up-down {
	0% {
	    margin-top: 2px;
	    opacity: 0;
	}
	30% {
	    opacity: 1;
	}
	100% {
	    margin-top: 20px;
	    opacity: 0;
	}
}
@-moz-keyframes wheel-up-down {
	0% {
	    margin-top: 2px;
	    opacity: 0;
	}
	30% {
	    opacity: 1;
	}
	100% {
	    margin-top: 20px;
	    opacity: 0;
	}
}@keyframes wheel-up-down {
	0% {
	    margin-top: 2px;
	    opacity: 0;
	}
	30% {
	    opacity: 1;
	}
	100% {
	    margin-top: 20px;
	    opacity: 0;
	}
}

</style>