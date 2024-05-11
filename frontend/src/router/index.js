import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '@/stores/user'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  linkActiveClass: 'is-active',
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/views/home.vue'),
    },
    {
      path: '/sign_in',
      name: 'sign_in',
      component: () => import('@/views/sign_in.vue'),
      meta: { layout: 'guest', permitGuest: true, onlyPermitGuest: true },
    },
    {
      path: '/sign_up',
      name: 'sign_up',
      component: () => import('@/views/sign_up.vue'),
      meta: { layout: 'guest', permitGuest: true, onlyPermitGuest: true },
    },
    {
      path: '/forgot_password',
      name: 'forgot_password',
      component: () => import('@/views/forgot_password.vue'),
      meta: { layout: 'guest', permitGuest: true, onlyPermitGuest: true },
    },
    {
      path: '/reset_password/:token',
      name: 'reset_password',
      component: () => import('@/views/reset_password.vue'),
      props: true,
      meta: { layout: 'guest', permitGuest: true, onlyPermitGuest: true },
    },
    {
      path: '/not_verified/:userId',
      name: 'not_verified',
      component: () => import('@/views/not_verified.vue'),
      props: true,
      meta: { layout: 'guest', permitGuest: true, onlyPermitGuest: true },
    },
    {
      path: '/verify/:token',
      name: 'verify',
      component: () => import('@/views/verify.vue'),
      props: true,
      meta: { layout: 'guest', permitGuest: true, onlyPermitGuest: true },
    },
  ],
})

const handleBeforeEach = function({ to, next, user }) {
  if (to.matched.every(record => record.meta.onlyPermitGuest === true) && user.isLoggedIn) {
    console.log('Already logged in. Redirecting to home.')
    next('/')
  } else if (to.matched.every(record => record.meta.permitGuest !== true) && !user.isLoggedIn) {
    console.log('Not logged in. Redirecting to sign in.')
    next('/sign_in')
  } else if (to.matched.some(record => record.name === 'admin') && !user.state.value.isAdmin) {
    console.log('You do not have permission to access the requested page. Redirecting to home.')
    next('/')
  } else {
    next()
  }
}

router.beforeEach((to, from, next) => {
  const user = useUserStore()

  if (!user.isLoggedIn) {
    user
      .initialize()
      .catch(() => { })
      .finally(() => handleBeforeEach({ to, from, next, user }))
  } else {
    handleBeforeEach({ to, from, next, user })
  }
})

export default router
