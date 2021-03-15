import addNotice from "./add_notice"

document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('[ajax-submit]').forEach(input => {
    input.addEventListener('change', () => {
      Rails.ajax({
        url: input.dataset.ajaxUrl,
        type: input.dataset.ajaxType,
        data: `${input.name}=${input.value}`,
        success: (res) => {
          addNotice({class: 'notice', message: res.message});
        },
        error: (err) => {
          addNotice({class: 'alert', message: res.message});
        }
      })
    })
  })
})
