export default {
  admin: {
    links: '/admin/links',
  },
  signIn: '/sign_in',
  signOut: (id) => `/sessions/${id}`,
  signUp: '/sign_up',
  users: {
    current: '/identity/current',
    resendVerification: (id) => `/identity/email_verification?uid=${id}`,
    resetPassword: '/identity/password_reset',
    sendPasswordReset: '/identity/password_reset',
    updateEmail: '/identity/email',
    updatePassword: '/identity/password',
    verify: '/identity/email_verification',
  },
}
