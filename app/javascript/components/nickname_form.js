const btn = document.getElementById('nickname-btn')
const form = document.getElementById('nickname-form')

const displayForm = () => {
  if (!!btn) {
    btn.addEventListener('click', () => {
      form.classList.toggle('d-none');
    })
  }
};

export { displayForm }
