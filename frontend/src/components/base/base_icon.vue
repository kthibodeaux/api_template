<script setup>
const props = defineProps({
  icon: { type: String, required: true },
  leftPadded: { type: Boolean, default: false },
  rightPadded: { type: Boolean, default: false },
})

const iconClass = `iconoir-${props.icon}`

const cssClasses = {
  [iconClass]: true,
  'pl-1': props.leftPadded,
  'pr-1': props.rightPadded,
}
</script>

<template lang="pug">
i(:class="cssClasses")
</template>
