export const autoFocus = () => {
    $('#join-modal').on('shown.bs.modal', function () {
      $('#passcode').trigger('focus')
      })

    $('#nickname-modal').on('shown.bs.modal', function () {
      $('#user_nickname').trigger('focus').trigger("select")
  })
}