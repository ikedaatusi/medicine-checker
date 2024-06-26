module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    "../medicine-checker/app/**/*.{html.erb,html,js}",
  ],
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      "bumblebee",
    ],
    },
    mode: "jit",
  }

