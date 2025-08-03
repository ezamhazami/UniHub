
document.addEventListener("DOMContentLoaded", function () {
  const toggle = document.querySelector('.menu-toggle');
  const links = document.querySelector('.menu-links');

  toggle.addEventListener('click', () => {
    links.classList.toggle('show');
  });
});
