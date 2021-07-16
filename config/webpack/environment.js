const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const customConfig = require("./custom")
const pug = require('./loaders/pug')
const sass = require('./loaders/sass')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
);

const aliasConfig = {
    'jquery': 'jquery-ui-dist/external/jquery/jquery.js',
    'jquery-ui': 'jquery-ui-dist/jquery-ui.js'
};

environment.config.set('resolve.alias', aliasConfig);


environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('sass', sass)
environment.loaders.prepend('pug', pug)
environment.config.merge(customConfig)
environment.loaders.append('vue', vue)
module.exports = environment
