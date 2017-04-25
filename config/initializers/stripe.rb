Rails.configuration.stripe = {
  :publishable_key => 'pk_test_ixp0aLgyogFPpusCwid6E9Zw',
  :secret_key      => 'sk_test_79zdacBlorRqe7ri57SM7uUQ'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
