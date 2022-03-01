export const autoFocus = () => {
    const nickNamebtn = document.getElementById("nickname-btn");
    const form = document.getElementById("user_nickname");
    const pin = document.getElementById("passcode");
    const joinBtn = document.getElementById("join-btn")
    
    nickNamebtn.addEventListener("click", (e) => {
        setTimeout(() => {
            form.select();
        },500 )
    })

    joinBtn.addEventListener("click", (e) => {
        setTimeout(() => {
            pin.select();
        },500 )
    })

}
