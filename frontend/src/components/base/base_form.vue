<script setup>
defineProps({
  error: { type: String, default: null },
})

const emit = defineEmits(['submit'])
</script>

<template lang="pug">
form(@submit.prevent="emit('submit')")
  .field.has-text-centered(v-if="error")
    p.has-text-danger {{ error }}
  slot
</template>
