<script setup>
import { computed } from 'vue'

const props = defineProps({
  icon: { type: String, required: true },
  leftPadded: { type: Boolean, default: false },
})

const iconClass = computed(() => {
  return `iconoir-${props.icon}`
})

const cssClasses = computed(() => {
  return {
    [iconClass.value]: true,
    'pl-1': props.leftPadded,
  }
})
</script>

<template lang="pug">
i(:class="cssClasses")
</template>
