# frozen_string_literal: true

require 'pagy'

# Extras
# See https://ddnexus.github.io/pagy/extras

# Backend Extras

# Array extra: Paginate arrays efficiently, avoiding expensive
# array-wrapping and without overriding
# See https://ddnexus.github.io/pagy/extras/array
require 'pagy/extras/array'

# Feature Extras

# Overflow extra: Allow for easy handling of overflowing pages
# See https://ddnexus.github.io/pagy/extras/overflow
require 'pagy/extras/overflow'

Pagy::DEFAULT[:overflow] = :empty_page
