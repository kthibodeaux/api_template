<script setup>
import { computed } from 'vue'
import useValidation from '@/lib/validation'

const text = defineModel()

const props = defineProps({
  isRequired: { type: Boolean, default: false },
  leftIcon: { type: String, default: null },
  type: { type: String, default: 'text' },
})

const additionalClasses = computed(() => {
  return {
    'has-icons-left': props.leftIcon,
  }
})

const { showError, updateValidity } = useValidation()
</script>

<template lang="pug">
.field
  label.label
    slot
  .control(:class="additionalClasses")
    input.input(
      @focus="updateValidity"
      @input="updateValidity"
      :class="{ 'is-danger': showError }"
      :required="isRequired"
      :type="type"
      v-model="text"
    )
    span.icon.is-small.is-left(v-if="leftIcon")
      BaseIcon(:icon="leftIcon")
</template>
