<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'

import GuestLayout from '@/layouts/guest.vue'
import MainLayout from '@/layouts/main.vue'

const route = useRoute()

const layouts = {
  default: MainLayout,
  guest: GuestLayout,
}

const layout = computed(() => {
  return layouts[route.meta.layout || 'default']
})
</script>

<template lang="pug">
Component(:is="layout")
  RouterView
</template>
