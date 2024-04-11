<script setup>
const props = defineProps({
  icon: { type: String, required: true },
  leftPadded: { type: Boolean, default: false },
})

const iconClass = `iconoir-${props.icon}`

const cssClasses = {
  [iconClass]: true,
  'pl-1': props.leftPadded,
}
</script>

<template lang="pug">
i(:class="cssClasses")
</template>
