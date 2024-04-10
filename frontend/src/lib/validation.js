import { computed, ref } from 'vue'

export default () => {
  const isTouched = ref(false)
  const isValid = ref(false)

  const showError = computed(() => {
    return isTouched.value && !isValid.value
  })

  const updateValidity = (event) => {
    isTouched.value = true
    isValid.value = event.srcElement.validity.valid
  }

  return {
    showError,
    updateValidity,
  }
}
