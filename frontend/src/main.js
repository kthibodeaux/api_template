import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './app.vue'
import router from './router'

const app = createApp(App)

app.use(createPinia())
app.use(router)

import BaseCheckbox from '@/components/base/base_checkbox.vue'
app.component('BaseCheckbox', BaseCheckbox)
import BaseForm from '@/components/base/base_form.vue'
app.component('BaseForm', BaseForm)
import BaseInput from '@/components/base/base_input.vue'
app.component('BaseInput', BaseInput)
import BaseSubmitButton from '@/components/base/base_submit_button.vue'
app.component('BaseSubmitButton', BaseSubmitButton)

app.mount('#app')
