import axios from '@/lib/axios'

export default function({ method = 'post', endpoint, data }) {
  return new Promise((resolve, reject) => {
    if (method === 'post') {
      axios
        .post(endpoint, data)
        .then(response => {
          if (response.data) {
            resolve(response.data)
          } else {
            resolve()
          }
        })
        .catch(error => {
          reject(error.response.data.errors)
        })
    } else if (method === 'delete') {
      axios
        .delete(endpoint)
        .then((response) => {
          if (response.data) {
            resolve(response.data)
          } else {
            resolve()
          }
        })
        .catch((error) => {
          reject(error.response.data.errors)
        })
    }
  })
}
