import { computed, ref } from 'vue'

export default function({ validationFunction } = {}) {
  const errorMessage = ref(null)
  const isTouched = ref(false)
  const isValid = ref(false)

  const showError = computed(() => {
    return isTouched.value && !isValid.value
  })

  const updateValidity = (event) => {
    isTouched.value = true

    if (validationFunction) {
      const result = validationFunction()

      if (result) {
        event.srcElement.setCustomValidity(result)
      } else {
        event.srcElement.setCustomValidity('')
      }
    }

    errorMessage.value = event.srcElement.validationMessage
    isValid.value = event.srcElement.validity.valid
  }

  return {
    errorMessage,
    showError,
    updateValidity,
  }
}
