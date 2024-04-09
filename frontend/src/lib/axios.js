import axios from 'axios'
import endpoints from './endpoints'
import router from '@/router'
import { useRoute } from 'vue-router'
import { useUserStore } from '@/stores/user'

const myAxios = axios.create({
  baseURL: process.env.API_URL,
  headers: {
    post: {
      'Content-Type': 'application/json',
    },
  },
  withCredentials: true,
})

myAxios.interceptors.response.use(
  function(response) {
    return response
  },
  function(error) {
    const user = useUserStore()

    if (!error.response) {
      console.error(error.message)
    } else if (error.response.status === 401) {
      if (user.isLoggedIn) {
        console.error('Unauthorized. Logging out')

        myAxios
          .delete(endpoints.users.logout)
          .finally(() => {
            user.logout()
          })
      }
    } else if (error.response.status === 404) {
      console.error('Record not found. Redirecting to /')

      router.replace('/')
    }
    return Promise.reject(error)
  },
)

export default myAxios
