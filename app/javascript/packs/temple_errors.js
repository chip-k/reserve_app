function changeBorderStyle(element) {
  if (element.value.trim() !== '') {
    element.style.borderColor = 'lightgray';
  } else {
    element.style.borderColor = 'red';
  }
}

document.addEventListener('DOMContentLoaded', function() {
  
  const newTempleNameInput = document.getElementById('new-temple-name');
  if (newTempleNameInput) {
    newTempleNameInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newTempleNameKanaInput = document.getElementById('new-temple-name-kana');
  if (newTempleNameKanaInput) {
    newTempleNameKanaInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newTemplePostalCodeInput = document.getElementById('new-temple-postal-code');
  if (newTemplePostalCodeInput) {
    newTemplePostalCodeInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newTemplePrefectureCodeInput = document.getElementById('new-temple-prefecture-code');
  if (newTemplePrefectureCodeInput) {
    newTemplePrefectureCodeInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newTempleEmailInput = document.getElementById('new-temple-email');
  if (newTempleEmailInput) {
    newTempleEmailInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newTempleAddressInput = document.getElementById('new-temple-address');
  if (newTempleAddressInput) {
    newTempleAddressInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newTemplePhoneNumberInput = document.getElementById('new-temple-phone-number');
  if (newTemplePhoneNumberInput) {
    newTemplePhoneNumberInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newTemplePasswordLengthInput = document.getElementById('new-temple-password-length');
  if (newTemplePasswordLengthInput) {
    newTemplePasswordLengthInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newTemplePasswordInput = document.getElementById('new-temple-password');
  if (newTemplePasswordInput) {
    newTemplePasswordInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newTemplePasswordConfirmationInput = document.getElementById('new-temple-password-confirmation');
  if (newTemplePasswordConfirmationInput) {
    newTemplePasswordConfirmationInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTempleNameInput = document.getElementById('edit-temple-name');
  if (editTempleNameInput) {
    editTempleNameInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTempleNameKanaInput = document.getElementById('edit-temple-name-kana');
  if (editTempleNameKanaInput) {
    editTempleNameKanaInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTemplePostalCodeInput = document.getElementById('edit-temple-postal-code');
  if (editTemplePostalCodeInput) {
    editTemplePostalCodeInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTemplePrefectureCodeInput = document.getElementById('edit-temple-prefecture-code');
  if (editTemplePrefectureCodeInput) {
    editTemplePrefectureCodeInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTempleAddressInput = document.getElementById('edit-temple-address');
  if (editTempleAddressInput) {
    editTempleAddressInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTempleEmailInput = document.getElementById('edit-temple-email');
  if (editTempleEmailInput) {
    editTempleEmailInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTemplePhoneNumberInput = document.getElementById('edit-temple-phone-number');
  if (editTemplePhoneNumberInput) {
    editTemplePhoneNumberInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTemplePasswordLengthInput = document.getElementById('edit-temple-password-length');
  if (editTemplePasswordLengthInput) {
    editTemplePasswordLengthInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTemplePasswordConfirmationInput = document.getElementById('edit-temple-password-confirmation');
  if (editTemplePasswordConfirmationInput) {
    editTemplePasswordConfirmationInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editTempleCurrentPasswordInput = document.getElementById('edit-temple-current-password');
  if (editTempleCurrentPasswordInput) {
    editTempleCurrentPasswordInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
});


function changeBorderStyles(element) {
  const values = element.value.trim().replace(/\r\n|\r|\n/g, '  ');
  if (values.length > 350) {
    element.style.borderColor = 'red';
  } else {
    element.style.borderColor = 'lightgray';
  }
}

document.addEventListener('DOMContentLoaded', function() {
  
  const editTempleIntroductionInput = document.getElementById('edit-temple-introduction');
  if (editTempleIntroductionInput) {
    editTempleIntroductionInput.addEventListener('input', function() {
      changeBorderStyles(this);
    });
  }
  
});