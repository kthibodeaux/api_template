import { createRouter, createWebHistory } from 'vue-router'

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
      meta: { layout: 'guest' },
    },
  ],
})

export default router
