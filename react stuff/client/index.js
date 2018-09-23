import React from 'react'
import ReactDOM from 'react-dom'
import App from './app'

// establishes socket connection

ReactDOM.render(
  <Provider>
      <App />
  </Provider>,
  document.getElementById('app')
)