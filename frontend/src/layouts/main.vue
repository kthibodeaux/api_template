<script setup>
import { ref } from 'vue'
import { useUserStore } from '@/stores/user'

const user = useUserStore()
const isOpen = ref(false)

const goodJobUrl = `${process.env.API_URL}/good_job`
</script>

<template lang="pug">
template(v-if="user.isLoggedIn")
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
          .navbar-item.has-dropdown.is-hoverable
            a.navbar-link {{user.state.email}}
            .navbar-dropdown
              template(v-if="user.state.isAdmin")
                a.navbar-item(:href="goodJobUrl")
                  | GoodJob
                  BaseIcon(icon="thumbs-up" left-padded)
                hr.navbar-divider
              a.navbar-item(@click="user.signOut" href="#") Sign Out

  .container
    slot
</template>
