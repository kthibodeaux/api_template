<script setup>
import endpoints from '@/lib/endpoints'
import runQuery from '@/lib/run_query'
import { watch, ref } from 'vue'
import { useUserStore } from '@/stores/user'

const user = useUserStore()
const isOpen = ref(false)

const adminLinks = ref([])
watch(
  () => user.state.isAdmin,
  (isAdmin) => {
    if (adminLinks.value.length === 0 && isAdmin) {
      runQuery({ endpoint: endpoints.admin.links })
        .then(data => {
          adminLinks.value = data
        })
    }
  },
  { immediate: true },
)
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
              template(v-if="adminLinks.length > 0")
                a.navbar-item(v-for="adminLink in adminLinks" :href="adminLink.url" :key="adminLink.name")
                  | {{adminLink.name}}
                  BaseIcon(:icon="adminLink.icon" left-padded)
                hr.navbar-divider
              a.navbar-item(@click="user.signOut" href="#") Sign Out

  .container
    slot
</template>
