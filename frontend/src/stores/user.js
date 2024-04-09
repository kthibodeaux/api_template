import axios from '@/lib/axios'
import endpoints from '@/lib/endpoints'
import runQuery from '@/lib/run_query'
import { computed } from 'vue'
import { defineStore } from 'pinia'
import { ref } from 'vue'

const defaultState = function() {
  return {
    email: ref(null),
    isAdmin: ref(false),
    sessionId: ref(null),
  }
}

export const useUserStore = defineStore('userStore', () => {
  const state = ref(defaultState())

  function setState(data) {
    state.value.email = data.user.email
    state.value.isAdmin = data.user.isAdmin
    state.value.sessionId = data.session.id
  }

  function initialize() {
    state.value = defaultState()

    return new Promise((resolve, reject) => {
      runQuery({ endpoint: endpoints.users.current })
        .then((data) => {
          setState(data)
          resolve()
        })
        .catch(() => {
          reject()
        })
    })
  }

  const login = function(credentials) {
    return new Promise((resolve, reject) => {
      axios
        .post(endpoints.users.login, { session: credentials })
        .then(response => {
          setState(response.data)
          resolve()
        })
        .catch((error) => {
          reject(error.response.data.error)
        })
    })
  }

  const logout = function() {
    axios
      .delete(endpoints.users.logout(state.value.sessionId))
      .finally(() => {
        state.value = defaultState()
        location.href = '/login'
      })
  }

  const isLoggedIn = computed(() => {
    return !!state.value.sessionId
  })

  return {
    initialize,
    isLoggedIn,
    login,
    logout,
    state,
  }
})
