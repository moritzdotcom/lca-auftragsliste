document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.input').forEach(input => {
    if ((input.querySelector('input') && input.querySelector('input').value) || (input.querySelector('select') && input.querySelector('select').options.selectedIndex != 0) || (input.querySelector('textarea') && input.querySelector('textarea').value)) {
      input.classList.add('has-value')
    }
    else {
      input.classList.remove('has-value')
    }
    input.addEventListener('change', () => {
      if ((input.querySelector('input') && input.querySelector('input').value) || (input.querySelector('select') && input.querySelector('select').options.selectedIndex != 0) || (input.querySelector('textarea') && input.querySelector('textarea').value)) {
        input.classList.add('has-value')
      }
      else {
        input.classList.remove('has-value')
      }
    })
  })
})
