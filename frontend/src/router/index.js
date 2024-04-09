import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '@/stores/user'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  linkActiveClass: 'is-selected',
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/views/home.vue'),
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/views/login.vue'),
      meta: { layout: 'guest', permitGuest: true, onlyPermitGuest: true },
    },
  ],
})

const handleBeforeEach = function({ to, next, user }) {
  if (to.matched.every(record => record.meta.onlyPermitGuest === true) && user.isLoggedIn) {
    console.log('Already logged in. Redirecting to root.')
    next('/')
  } else if (to.matched.every(record => record.meta.permitGuest !== true) && !user.isLoggedIn) {
    console.log('Not logged in. Redirecting to login.')
    next('/login')
  } else if (to.matched.some(record => record.name === 'admin') && !user.state.value.isAdmin) {
    console.log('You do not have permission to access the requested page. Redirecting to login.')
    next('/')
  } else {
    next()
  }
}

router.beforeEach((to, from, next) => {
  const user = useUserStore()

  if (user.state.id === null) {
    user
      .initialize()
      .finally(() => handleBeforeEach({ to, from, next, user }))
  } else {
    handleBeforeEach({ to, from, next, user })
  }
})

export default router
