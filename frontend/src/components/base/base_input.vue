<script setup>
import { computed, ref, watch } from 'vue'
import useValidation from '@/lib/validation'

const text = defineModel()
const validationWatch = defineModel('validationWatch')

const props = defineProps({
  isRequired: { type: Boolean, default: false },
  minlength: { type: String, default: null },
  leftIcon: { type: String, default: null },
  type: { type: String, default: 'text' },
  validation: { type: Function, default: null },
})

const additionalClasses = computed(() => {
  return {
    'has-icons-left': props.leftIcon,
  }
})

const inputField = ref(null)
watch(validationWatch, () => {
  updateValidity(inputField.value)
})

const { errorMessage, showError, updateValidity } = useValidation({
  validationFunction: props.validation,
})
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
      :minlength="minlength"
      :required="isRequired"
      :type="type"
      ref="inputField"
      v-model="text"
    )
    span.icon.is-small.is-left(v-if="leftIcon")
      BaseIcon(:icon="leftIcon")
  p.help.is-danger(v-if="errorMessage") {{errorMessage}}
</template>
