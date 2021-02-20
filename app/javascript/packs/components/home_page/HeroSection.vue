<template lang="pug">
  section.hero-section
    h1.discover
      | explore
      .page-scroll-indicator
        .page-scroll-wheel
</template>

<script>
export default {
  name: 'HeroSection'
}
</script>

<style>

.hero-section {
  background-image: url('../../images/hero-banner.png');
  height: 100vh;
  background-size: cover;
}

.discover {
  display: flex;
  color: white;
  font-family: 'Montserrat';
  padding-top: 46rem;
  padding-left:  7rem;
  font-weight: 600;
}

/* .page-scroll-indicator {
  width: 30px;
  height: 45px;
  border: solid 3px white;
  margin-left: 40px;
  border-radius: 15px;
}

.page-scroll-indicator::after {
  content: '•';
  display: block;
  left: 1px;
  border-radius: 5px;
} */

.page-scroll-indicator {
   margin-left: 40px;
   width: 30px;
   height: 50px;
   border: 3px solid white; /*you can change 'white' to a hex color*/
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
  background-color: white; /*you can change 'white' to a hex color*/
  border-radius: 50%;
  -webkit-animation: 1.6s ease infinite wheel-up-down;
 -moz-animation: 1.6s ease infinite wheel-up-down;
  animation: 1.6s ease infinite wheel-up-down;
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