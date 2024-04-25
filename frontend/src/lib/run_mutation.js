import axios from '@/lib/axios'

export default function({ method = 'post', endpoint, data }) {
  return new Promise((resolve, reject) => {
    const success = (response) => {
      if (response.data) {
        resolve(response.data)
      } else {
        resolve()
      }
    }

    const failure = (error) => {
      if (error.response) {
        reject(error.response.data.errors)
      } else {
        reject(error)
      }
    }

    if (method === 'post') {
      axios
        .post(endpoint, data)
        .then(success)
        .catch(failure)
    } else if (method === 'delete') {
      axios
        .delete(endpoint)
        .then(success)
        .catch(failure)
    } else if (method === 'patch') {
      axios
        .patch(endpoint, data)
        .then(success)
        .catch(failure)
    } else if (method === 'put') {
      axios
        .put(endpoint, data)
        .then(success)
        .catch(failure)
    }
  })
}
