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
  
  const newArticleTitleInput = document.getElementById('new-article-title');
  if (newArticleTitleInput) {
    newArticleTitleInput.addEventListener('input', function() {
      changeBorderStyle(this, 'new-article-title-error');
    });
  }
  
  const newArticleContentInput = document.getElementById('new-article-content');
  if (newArticleContentInput) {
    newArticleContentInput.addEventListener('input', function() {
      changeBorderStyle(this, 'new-article-content-error');
    });
  }
  
  const editArticleTitleInput = document.getElementById('edit-article-title');
  if (editArticleTitleInput) {
    editArticleTitleInput.addEventListener('input', function() {
      changeBorderStyle(this, 'edit-article-title-error');
    });
  }
  
  const editArticleContentInput = document.getElementById('edit-article-content');
  if (editArticleContentInput) {
    editArticleContentInput.addEventListener('input', function() {
      changeBorderStyle(this, 'edit-article-content-error');
    });
  }
  
});