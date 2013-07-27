class Subscription < ActiveRecord::Base
  belongs_to :user

  attr_accessible :stripe_card_token, :user_id

  attr_accessor :stripe_card_token

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: user_id, plan: "Premium", card: stripe_card_token)
      self.stripe_card_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
