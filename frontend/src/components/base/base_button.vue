<script setup>
const props = defineProps({
  fullwidth: { type: Boolean, default: false },
  link: { type: Boolean, default: false },
  primary: { type: Boolean, default: false },
  submit: { type: Boolean, default: false },
})

const cssClasses = {
  'is-fullwidth': props.fullwidth,
  'is-link': props.link,
  'is-primary': props.primary,
}

const type = props.submit ? 'submit' : null
</script>

<template lang="pug">
button.button(:class="cssClasses" :type="type")
  slot
</template>
