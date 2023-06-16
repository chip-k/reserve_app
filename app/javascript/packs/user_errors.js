function changeBorderStyle(element) {
  if (element.value.trim() !== '') {
    element.style.borderColor = 'lightgray';
  } else {
    element.style.borderColor = 'red';
  }
}

document.addEventListener('DOMContentLoaded', function() {
  
  const newUserNameInput = document.getElementById('new-user-name');
  if (newUserNameInput) {
    newUserNameInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newUserNameKanaInput = document.getElementById('new-user-name-kana');
  if (newUserNameKanaInput) {
    newUserNameKanaInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newUserPostalCodeInput = document.getElementById('new-user-postal-code');
  if (newUserPostalCodeInput) {
    newUserPostalCodeInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newUserEmailInput = document.getElementById('new-user-email');
  if (newUserEmailInput) {
    newUserEmailInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newUserPhoneNumberInput = document.getElementById('new-user-phone-number');
  if (newUserPhoneNumberInput) {
    newUserPhoneNumberInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newUserPasswordLengthInput = document.getElementById('new-user-password-length');
  if (newUserPasswordLengthInput) {
    newUserPasswordLengthInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newUserPasswordInput = document.getElementById('new-user-password');
  if (newUserPasswordInput) {
    newUserPasswordInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const newUserPasswordConfirmationInput = document.getElementById('new-user-password-confirmation');
  if (newUserPasswordConfirmationInput) {
    newUserPasswordConfirmationInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editUserNameInput = document.getElementById('edit-user-name');
  if (editUserNameInput) {
    editUserNameInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editUserNameKanaInput = document.getElementById('edit-user-name-kana');
  if (editUserNameKanaInput) {
    editUserNameKanaInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editUserPostalCodeInput = document.getElementById('edit-user-postal-code');
  if (editUserPostalCodeInput) {
    editUserPostalCodeInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editUserEmailInput = document.getElementById('edit-user-email');
  if (editUserEmailInput) {
    editUserEmailInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editUserPhoneNumberInput = document.getElementById('edit-user-phone-number');
  if (editUserPhoneNumberInput) {
    editUserPhoneNumberInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editUserPasswordLengthInput = document.getElementById('edit-user-password-length');
  if (editUserPasswordLengthInput) {
    editUserPasswordLengthInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editUserPasswordConfirmationInput = document.getElementById('edit-user-password-confirmation');
  if (editUserPasswordConfirmationInput) {
    editUserPasswordConfirmationInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editUserCurrentPasswordInput = document.getElementById('edit-user-current-password');
  if (editUserCurrentPasswordInput) {
    editUserCurrentPasswordInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
});