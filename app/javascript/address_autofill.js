$(function() {
  $(document).on('turbolinks:load', () => {
    $('#user_postal_code').jpostal({
      postcode : [
        '#user_postal_code'
      ],
      address: {
        "#user_prefecture_code": "%3",
        "#user_city"           : "%4%5",
        "#user_street"         : "%6%7"
      }
    });
  });
});