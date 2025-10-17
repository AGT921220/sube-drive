<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Getting Ready...</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/payment.css">
  <style>
  
  
  .top-new{    max-width: 100%;
    margin: 50px auto;
    background: #fff;
    border-radius: 8px;
    margin-bottom: 0px;box-shadow: 0 4px 6px rgba(0, 0, 0,);}
.payment-list {
 max-width: 100%;
    margin: 50px auto;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    margin-top: 0px;
}

.payment-item {
  /* display: flex; */
  align-items: center;
  justify-content: space-between;
  padding: 15px 11px;
  border-bottom: 1px solid #ddd;
  cursor: pointer;
  transition: background 0.3s;
}

.payment-item:hover {
  background: #f1f1f1;
}

.payment-item img {
  width: 87px;
  height: 43px;
  object-fit: contain;
  margin-right: 35px;
}

.payment-item span {
  font-size: 16px;
  color: #333;
}

.payment-item .arrow {font-size: 29px;color: #888;position: relative;top: -2px;float: right;padding-right: 15px;}

  </style>
  
</head>
<body>
<div class="loader-overlay" style='display:none'>
  <div class="loader"></div>
  <div class="loader-text">In process ...</div>
</div>
<div class="container">



<div class=" text-center top-new" style="margin-top:30px;">
      <h2 class="mb-4">Choose payment gateway:</h2>
    </div>

  {{--<div class="payment-list">
  
    <div class="payment-item">
      <img src="https://vehicle.unibooker.app/front/images/Razorpay.png" alt="Razorpay Logo">
      <span>Razorpay</span>
      <span class="arrow">&#8250;</span>
    </div>
    <div class="payment-item">
      <img src="https://vehicle.unibooker.app/front/images/Amazon.png" alt="Amazon Pay Logo">
      <span>Amazon Pay</span>
      <span class="arrow">&#8250;</span>
    </div>
    <div class="payment-item">
      <img src="https://vehicle.unibooker.app/front/images/MobiKwik.png" alt="MOMIWIRK Logo">
      <span>MobiKwik</span>
      <span class="arrow">&#8250;</span>
    </div>
    <div class="payment-item">
      <img src="https://vehicle.unibooker.app/front/images/Paytm.png" alt="Paytm Logo">
      <span>Paytm</span>
      <span class="arrow">&#8250;</span>
    </div>
    <div class="payment-item">
      <img src="https://vehicle.unibooker.app/front/images/PhonePe.png" alt="PhonePe Logo">
      <span>PhonePe</span>
      <span class="arrow">&#8250;</span>
    </div>
  </div> --}}

  <div class="payment-list">
    @foreach ($paymentMethods as $method => $details)
    @if ($details['active'])
        <div class="payment-item" @if($method == 'paypal') class="noinel" @endif @if($method == 'stripe') id="{{ $details['id'] }}" @endif>
        @if ($details['form'])
          <!-- Form Submission for Payment Method -->
          <form action="{{ $details['route'] }}" method="post" id="{{ $details['id'] }}" class="payment-form">
              @csrf
              <!-- Wrapping the whole payment item in a clickable area -->
              <div onclick="document.getElementById('{{ $method }}-button').click()">
                  <img src="{{ $details['image'] }}" 
                      alt="Pay via {{ ucfirst($method) }}" 
                      class="payment-image">
                  <span class="payment-method-name">{{ ucfirst($method) }}</span>
                  <span class="arrow">&#8250;</span>
                  <button type="submit" style="display: none;" id="{{ $method }}-button">
                      <!-- Hidden submit button for form submission -->
                  </button>
              </div>
          </form>
      @else
          <!-- Link for Payment Method without Form -->
          <a href="{{ $details['route'] }}" >
                    <!-- Make the whole div clickable -->
                    <img src="{{ $details['image'] }}" 
                         alt="Pay via {{ ucfirst($method) }}" 
                         class="payment-image">
                    <span class="payment-method-name">{{ ucfirst($method) }}</span>
                    <span class="arrow">&#8250;</span>
                </a>
      @endif

        </div>
    @endif
    @if ($method == 'stripe' && Route::currentRouteName() == 'wallet_recharge_form')
        @break
    @endif
@endforeach

</div>
{{--<div class="row">
    <div class="col-12 text-center" style="margin-top:30px;">
      <h2 class="mb-4">Choose payment gateway:</h2>
    </div>
  </div>
  <div class="row">
    <div class="icons-payment">
    

      <ul>
    @foreach ($paymentMethods as $method => $details)
        @if ($details['active'])
        <li @if($method == 'paypal') class="noinel" @endif>
                @if ($details['form'])
                    <form action="{{ $details['route'] }}" method="post" id="{{ $details['id'] }}">
                        @csrf
                        <button type="submit" id="{{ $method }}-button">
                            <img src="{{ $details['image'] }}" alt="Pay via {{ ucfirst($method) }}">
                        </button>
                    </form>
                @else
                    <a href="javascript:;" id="{{ $details['id'] }}">
                        <img src="{{ $details['image'] }}" alt="Pay via {{ ucfirst($method) }}">
                    </a>
                @endif
            </li>
        @endif
        @if ($method == 'stripe' && Route::currentRouteName() == 'wallet_recharge_form')
            @break
        @endif
    @endforeach
</ul>
    </div>
  </div>--}}
</div>
<div class="modal fade" id="stripeModal" tabindex="-1" role="dialog" aria-labelledby="stripeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="stripeModalLabel">Stripe Payment</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <form 
          action="{{ Route::currentRouteName() == 'wallet_recharge_form' ? route('wallet_recharge_form', ['userToken' =>request()->query('token'), 'method' => 'stripe', 'amount' =>request()->query('amount'), 'currency' =>request()->query('currency')]) : route('payment', ['booking' => $bookingId, 'method' => 'stripe']) }}" 
          method="post" id="payment-form">
          @csrf
          <input type="hidden" id="order_id" name="order_id" value="{{ request()->query('booking') }}" required>
          <input type="hidden" name="stripeToken" id="stripeToken">
          <input type="hidden" name="userToken" id="userToken" value="{{ request()->query('token') }}">
          <input type="hidden" name="amount" id="amount" value="{{ request()->query('amount') }}">
          <input type="hidden" name="currency" id="currency" value="{{ request()->query('currency') }}">
          <div class="form-group">
            <label for="card-number">Card Number</label>
            <div id="card-number" class="form-control"></div>
          </div>

          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="card-expiry">Expiration Date</label>
              <div id="card-expiry" class="form-control"></div>
            </div>
            <div class="form-group col-md-6">
              <label for="card-cvc">CVV Code</label>
              <div id="card-cvc" class="form-control"></div>
            </div>
          </div>

          <div id="card-errors" role="alert" class="alert alert-danger"></div>
          <div id="error-message" class="alert alert-danger" role="alert" style="display: none;"></div>
          <div id="loader" class="spinner-border text-primary" role="status" style="display: none;">
            <span class="sr-only">Loading...</span>
          </div>
          <button type="submit" id="submit-button" class="btn btn-primary btn-block mt-3">Submit Payment</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Add Bootstrap JS and jQuery scripts here -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Include Stripe.js script -->
<script src="https://js.stripe.com/v3/"></script>


<!-- JavaScript for the loader and Stripe integration -->
<script>
  $(document).ready(function() {

    $("#paypal-form").submit(function(event) {
  event.preventDefault();
  $('.loader-overlay').show();
  this.submit();
});


$("#razorpay-form").submit(function(event) {
  event.preventDefault();
  $('.loader-overlay').show();
  this.submit();
});

$("#payduniya-form").submit(function(event) {
  event.preventDefault();
  $('.loader-overlay').show();
  this.submit();
});


    $("#stripe-link").click(function() {
      console.log("Clicked on Stripe link");
      $('#stripeModal').modal('show');
    });


    
    $("#stripe-submit").click(function() {
      $('#stripeModal').modal('hide');
    });
  });

  var stripe = Stripe('{{$paymentMethods['stripe']['public_key']}}');
    var elements = stripe.elements();


    var style = {
            base: {
                fontSize: '16px',
                fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
                color: '#32325d',
            },
        };
        
  var cardNumber = elements.create('cardNumber', { style: style });
        cardNumber.mount('#card-number');

        var cardExpiry = elements.create('cardExpiry', { style: style });
        cardExpiry.mount('#card-expiry');

        var cardCvc = elements.create('cardCvc', { style: style });
        cardCvc.mount('#card-cvc');

        var form = document.getElementById('payment-form');
        var submitButton = document.getElementById('submit-button');

        form.addEventListener('submit', function(event) {
            event.preventDefault();
            submitButton.disabled = true;
            loader.style.display = 'block'; // Show the loader
            stripe.createToken(cardNumber).then(function(result) {
                if (result.error) {
                    // Inform the user if there was an error.
                    var errorElement = document.getElementById('card-errors');
                    errorElement.textContent = result.error.message;
                    loader.style.display = 'none';
                    submitButton.disabled = false;
                } else {
                    // Send the token to your server.
                    stripeTokenHandler(result.token);
                }
            });
        });

        function stripeTokenHandler(token) {
            // Insert the token ID into the form so it gets submitted to the server
            var form = document.getElementById('payment-form');
            var hiddenInput = document.createElement('input');
            var hiddenInput = document.getElementById('stripeToken');
              hiddenInput.setAttribute('value', token.id);
            hiddenInput.setAttribute('type', 'hidden');
            hiddenInput.setAttribute('name', 'stripeToken');
            hiddenInput.setAttribute('value', token.id);
            form.appendChild(hiddenInput);

            // Submit the form
            form.submit();
        }

        var errorMessage = '{{ session("error") }}';
    if (errorMessage) {
        var errorMessageElement = document.getElementById('error-message');
        errorMessageElement.textContent = errorMessage;
        errorMessageElement.style.display = 'block';
    }
</script>

<!-- Modal for Stripe payment -->


</body>
</html>
