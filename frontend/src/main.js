import './assets/main.css'

import { createApp } from 'vue'
import App from './app.vue'
const app = createApp(App)

import { createPinia } from 'pinia'
const pinia = createPinia()
app.use(pinia)

import router from './router'
app.use(router)

import BaseButton from '@/components/base/base_button.vue'
app.component('BaseButton', BaseButton)
import BaseCheckbox from '@/components/base/base_checkbox.vue'
app.component('BaseCheckbox', BaseCheckbox)
import BaseForm from '@/components/base/base_form.vue'
app.component('BaseForm', BaseForm)
import BaseIcon from '@/components/base/base_icon.vue'
app.component('BaseIcon', BaseIcon)
import BaseInput from '@/components/base/base_input.vue'
app.component('BaseInput', BaseInput)
import BaseSubmitButton from '@/components/base/base_submit_button.vue'
app.component('BaseSubmitButton', BaseSubmitButton)

app.mount('#app')
