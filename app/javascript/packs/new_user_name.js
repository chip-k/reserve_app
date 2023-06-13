document.addEventListener('turbolinks:load', function() {
  let deleteLink = document.getElementById('delete-user-link');
  let newUserNameField = document.getElementById('new-user-name');
  let newUserCheckbox = document.getElementById('new-user-checkbox');
  let addLink = document.getElementById('add-user-link');

  newUserCheckbox.addEventListener('change', function() {
    if (newUserCheckbox.checked) {
      if (deleteLink) {
        deleteLink.click();
      }
      newUserNameField.classList.remove('d-none');
      addLink.style.display = 'none';
    } else {
      newUserNameField.classList.add('d-none');
      addLink.style.display = 'block';
    }
  });
});