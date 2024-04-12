<script setup>
const emit = defineEmits(['submit'])
</script>

<template lang="pug">
form(@submit.prevent="emit('submit')")
  slot
</template>
