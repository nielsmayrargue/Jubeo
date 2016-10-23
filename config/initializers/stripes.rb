Rails.configuration.stripe = {
  :publishable_key => Figaro.env.stripes_publishable_key,
  :secret_key      => Figaro.env.stripes_secret_key
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]