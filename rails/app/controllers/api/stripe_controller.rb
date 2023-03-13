class Api::StripeController < Api::BaseController
  def webhook
    # payload = request.body.read
    # event = nil

    # begin
    #   event = Stripe::Event.construct_from(
    #     JSON.parse(payload, symbolize_names: true)
    #   )
    # rescue JSON::ParserError => e
    #   # Invalid payload
    #   status 400
    #   return
    # end

    # # Handle the event
    # case event.type
    #   when 'payment_intent.succeeded'
    #   payment_intent = event.data.object # contains a Stripe::PaymentIntent
    #   # Then define and call a method to handle the successful payment intent.
    #   # handle_payment_intent_succeeded(payment_intent)
    #   when 'payment_method.attached'
    #   payment_method = event.data.object # contains a Stripe::PaymentMethod
    #   # Then define and call a method to handle the successful attachment of a PaymentMethod.
    #   # handle_payment_method_attached(payment_method)
    #   # ... handle other event types
    # else
    #   # Unexpected event type
    #   status 400
    #   return
    # end

    # status 200
  end
end
