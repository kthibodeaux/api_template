import axios from '@/lib/axios'

export default function({ method = 'post', endpoint, data }) {
  return new Promise((resolve, reject) => {
    axios[method](endpoint, data)
      .then(response => {
        if (response.data) {
          resolve(response.data)
        } else {
          resolve()
        }
      })
      .catch(error => {
        if (error.response) {
          reject(error.response.data.errors)
        } else {
          reject(error)
        }
      })
  })
}
