export const showImposter = () => {
    const countdown = document.getElementById("countdown");
    const overlay = document.getElementById("overlay")
    const revealImposter = document.getElementById("impostor-reveal")

    const revealingImposter = () => {
        const timer = setInterval(() => {
            countdown.innerText -= 1
            if((parseInt(countdown.innerText)) === 0){
                console.log("hello")
                clearInterval(timer);
                overlay.classList.toggle("active")
                setTimeout(() => {
                    revealImposter.classList.toggle("d-none")
                },2000)
            }
        }, 1000)
    }

    if(!!overlay){ revealingImposter(); }
}
