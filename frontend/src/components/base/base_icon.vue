<script setup>
import { computed } from 'vue'

const props = defineProps({
  icon: { type: String, required: true },
})

const iconClass = computed(() => {
  return `iconoir-${props.icon}`
})
</script>

<template lang="pug">
i(:class="iconClass")
</template>
