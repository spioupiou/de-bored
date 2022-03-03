export const autoFocus = () => {
  const nickNameform = document.getElementById("user_nickname");
  const joinForm = document.getElementById("passcode")
    
    nickNameform.addEventListener("click",(e) => {
        e.currentTarget.select();
    })
    
    joinForm.addEventListener("click",(e) => {
        e.currentTarget.select();
    })
}