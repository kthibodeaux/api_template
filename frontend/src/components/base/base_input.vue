<script setup>
import { computed } from 'vue'

const text = defineModel()

const props = defineProps({
  isRequired: { type: Boolean, default: false },
  isSensitive: { type: Boolean, default: false },
  leftIcon: { type: String, default: null },
})

const inputType = computed(() => {
  return props.isSensitive ? 'password' : 'text'
})

const additionalClasses = computed(() => {
  return {
    'has-icons-left': props.leftIcon,
  }
})
</script>

<template lang="pug">
.field
  label.label
    slot
  .control(:class="additionalClasses")
    input.input(
      :required="isRequired"
      :type="inputType"
      v-model="text"
    )
    span.icon.is-small.is-left(v-if="leftIcon")
      BaseIcon(:icon="leftIcon")
</template>
