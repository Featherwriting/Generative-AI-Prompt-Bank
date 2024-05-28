const { generateWebpackConfig, merge } = require('shakapacker')

const options = {
  resolve: {
    extensions: ['.css', '.scss']
  }
}

module.exports = merge({}, generateWebpackConfig(), options)