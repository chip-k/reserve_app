function changeBorderStyle(element, errorElementId) {
  if (element.value.trim() !== '') {
    element.style.borderColor = 'lightgray';
    document.getElementById(errorElementId).style.display = 'none';
  } else {
    element.style.borderColor = 'red';
    document.getElementById(errorElementId).style.display = 'block';
  }
}

document.addEventListener('DOMContentLoaded', function() {
  
  const newPostTitleInput = document.getElementById('new-post-title');
  if (newPostTitleInput) {
    newPostTitleInput.addEventListener('input', function() {
      changeBorderStyle(this, 'new-post-title-error');
    });
  }
  
  const newPostBodyInput = document.getElementById('new-post-body');
  if (newPostBodyInput) {
    newPostBodyInput.addEventListener('input', function() {
      changeBorderStyle(this, 'new-post-body-error');
    });
  }
  
  const editPostTitleInput = document.getElementById('edit-post-title');
  if (editPostTitleInput) {
    editPostTitleInput.addEventListener('input', function() {
      changeBorderStyle(this, 'edit-post-title-error');
    });
  }
  
  const editPostBodyInput = document.getElementById('edit-post-body');
  if (editPostBodyInput) {
    editPostBodyInput.addEventListener('input', function() {
      changeBorderStyle(this, 'edit-post-body-error');
    });
  }
  
});