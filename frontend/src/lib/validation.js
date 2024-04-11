import { computed, ref } from 'vue'

export default function({ validationFunction } = {}) {
  const errorMessage = ref(null)
  const isTouched = ref(false)
  const isValid = ref(false)

  const showError = computed(() => {
    return isTouched.value && !isValid.value
  })

  const updateValidity = (incoming) => {
    isTouched.value = true
    const srcElement = incoming.srcElement ? incoming.srcElement : incoming

    if (validationFunction) {
      const result = validationFunction()

      if (result) {
        srcElement.setCustomValidity(result)
      } else {
        srcElement.setCustomValidity('')
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
