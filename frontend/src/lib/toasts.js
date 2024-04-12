import { Notyf } from 'notyf'
import 'notyf/notyf.min.css'

const notyf = new Notyf({
  duration: 2000,
  position: {
    x: 'center',
    y: 'top',
  },
  types: [
    {
      type: 'success',
      dismissible: true,
      duration: 2000,
      icon: {
        className: 'iconoir-check-circle-solid',
        color: 'white',
        tagName: 'i',
      },
      ripple: false,
    },
    {
      type: 'error',
      dismissible: true,
      duration: 5000,
      icon: {
        className: 'iconoir-warning-triangle-solid',
        color: 'white',
        tagName: 'i',
      },
      ripple: false,
    },
  ],
})

export const successToast = function(message) {
  notyf.success(message)
}

export const errorToast = function(message) {
  notyf.error(message)
}
