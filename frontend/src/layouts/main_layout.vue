<script setup>
import { ref } from 'vue'

const isOpen = ref(false)
</script>

<template lang="pug">
.container
  nav.navbar(role="navigation" aria-label="main navigation")
    .navbar-brand
      a.navbar-item(href="/") API Template App
      a.navbar-burger(role="button" data-target="navbar" @click="isOpen = !isOpen")
        span(aria-hidden="true")
        span(aria-hidden="true")
        span(aria-hidden="true")
        span(aria-hidden="true")
    #navbar.navbar-menu(:class="{ 'is-active': isOpen }" :key="$route.name")
      .navbar-start
        RouterLink.navbar-item(:to="{ name: 'home' }") Home
      .navbar-end

.container
  slot
</template>
