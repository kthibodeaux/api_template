<script setup>
import { computed } from 'vue'

const text = defineModel()

const props = defineProps({
  isRequired: { type: Boolean, default: false },
  isSensitive: { type: Boolean, default: false },
})

const inputType = computed(() => {
  return props.isSensitive ? 'password' : 'text'
})
</script>

<template lang="pug">
.field
  label.label
    slot
  .control
    input.input(
      :required="isRequired"
      :type="inputType"
      v-model="text"
    )
</template>
