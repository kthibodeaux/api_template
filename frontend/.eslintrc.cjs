/* eslint-env node */
require('@rushstack/eslint-patch/modern-module-resolution')

module.exports = {
  root: true,
  'rules': {
    'strict': 0,
    'comma-dangle': ['error', 'always-multiline'],
    'dot-location': ['error', 'property'],
    'no-multiple-empty-lines': ['error', { 'max': 1, 'maxEOF': 0, 'maxBOF': 0 }],
    'object-curly-spacing': ['error', 'always'],
    'padded-blocks': ['error', 'never'],
    'quote-props': ['warn', 'as-needed'],
    'quotes': ['warn', 'single', { 'avoidEscape': true }],
    'semi': ['warn', 'never'],
    'space-before-function-paren': ['warn', 'never'],
    'array-bracket-spacing': ['error'],
    'arrow-spacing': ['error'],
    'block-spacing': ['error'],
    'comma-spacing': ['error'],
    'computed-property-spacing': ['error'],
    'eqeqeq': ['warn'],
    'func-call-spacing': ['error'],
    'implicit-arrow-linebreak': ['error'],
    'key-spacing': ['error'],
    'keyword-spacing': ['error'],
    'no-console': ['warn'],
    'no-extra-parens': ['error'],
    'no-multi-spaces': ['error'],
    'no-tabs': ['error'],
    'no-var': ['error'],
    'operator-linebreak': ['error'],
    'rest-spread-spacing': ['error'],
    'semi-spacing': ['error'],
    'space-before-blocks': ['error'],
    'space-in-parens': ['error'],
    'space-infix-ops': ['error'],
    'vue/multi-word-component-names': 0,
    'vue/max-attributes-per-line': 100
  },
  'extends': [
    'plugin:vue/vue3-essential',
    'eslint:recommended',
    '@vue/eslint-config-prettier/skip-formatting',
    'plugin:vue-pug/vue3-recommended'
  ],
  parserOptions: {
    ecmaVersion: 'latest'
  }
}
