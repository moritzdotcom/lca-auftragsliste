const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    Rails: ['@rails/ujs']
  })
);

module.exports = environment
