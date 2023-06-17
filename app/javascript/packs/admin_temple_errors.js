function changeBorderStyle(element) {
  if (element.value.trim() !== '') {
    element.style.borderColor = 'lightgray';
  } else {
    element.style.borderColor = 'red';
  }
}

document.addEventListener('DOMContentLoaded', function() {
  
  const editAdminTempleNameInput = document.getElementById('edit-admin-temple-name');
  if (editAdminTempleNameInput) {
    editAdminTempleNameInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminTempleNameKanaInput = document.getElementById('edit-admin-temple-name-kana');
  if (editAdminTempleNameKanaInput) {
    editAdminTempleNameKanaInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminTemplePostalCodeInput = document.getElementById('edit-admin-temple-postal-code');
  if (editAdminTemplePostalCodeInput) {
    editAdminTemplePostalCodeInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminTemplePrefectureCodeInput = document.getElementById('edit-admin-temple-prefecture-code');
  if (editAdminTemplePrefectureCodeInput) {
    editAdminTemplePrefectureCodeInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminTempleAddressInput = document.getElementById('edit-admin-temple-address');
  if (editAdminTempleAddressInput) {
    editAdminTempleAddressInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminTempleEmailInput = document.getElementById('edit-admin-temple-email');
  if (editAdminTempleEmailInput) {
    editAdminTempleEmailInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
  const editAdminTemplePhoneNumberInput = document.getElementById('edit-admin-temple-phone-number');
  if (editAdminTemplePhoneNumberInput) {
    editAdminTemplePhoneNumberInput.addEventListener('input', function() {
      changeBorderStyle(this);
    });
  }
  
});