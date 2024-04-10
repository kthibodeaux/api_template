import { computed, ref } from 'vue'

export default function({ validationErrorMessage } = {}) {
  const isTouched = ref(false)
  const isValid = ref(false)

  const showError = computed(() => {
    return isTouched.value && !isValid.value
  })

  const updateValidity = (event) => {
    isTouched.value = true

    if (validationErrorMessage) {
      const result = validationErrorMessage()

      if (result) {
        event.srcElement.setCustomValidity(result)
      }
    }

    isValid.value = event.srcElement.validity.valid
  }

  return {
    showError,
    updateValidity,
  }
}
