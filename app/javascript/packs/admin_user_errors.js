function changeBorderStyle(element) {
  if (element.value.trim() !== '') {
    element.style.borderColor = 'lightgray';
  } else {
    element.style.borderColor = 'red';
  }
}

document.addEventListener('DOMContentLoaded', function() {
  
  const editAdminUserNameInput = document.getElementById('edit-admin-user-name');
  if (editAdminUserNameInput) {
    editAdminUserNameInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminUserNameKanaInput = document.getElementById('edit-admin-user-name-kana');
  if (editAdminUserNameKanaInput) {
    editAdminUserNameKanaInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminUserPostalCodeInput = document.getElementById('edit-admin-user-postal-code');
  if (editAdminUserPostalCodeInput) {
    editAdminUserPostalCodeInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminUserEmailInput = document.getElementById('edit-admin-user-email');
  if (editAdminUserEmailInput) {
    editAdminUserEmailInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminUserPhoneNumberInput = document.getElementById('edit-admin-user-phone-number');
  if (editAdminUserPhoneNumberInput) {
    editAdminUserPhoneNumberInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
});