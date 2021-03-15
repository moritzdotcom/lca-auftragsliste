module.exports = function addNotice(arg) {
  let className = arg.class || 'notice';
  document.getElementById('notice-container').insertAdjacentHTML('afterbegin', `<p class="${className}">${arg.message}</p>`)

  let notice = document.querySelector(`.${className}`)
  setTimeout(function() { notice.style.opacity = 0; }, 7000);
  setTimeout(function() { notice.style.display = 'none'; }, 7500);
}
