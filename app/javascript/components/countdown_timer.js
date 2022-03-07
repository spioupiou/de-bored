export const countdownTimer = () => {
    const timer = document.getElementById("timer");
    const ready = document.getElementById("ready");
    const time = document.getElementById("time");
    const newRoundBtn = document.getElementById("new_round");
    const countdown = document.getElementById("countdown");
    const overlay = document.getElementById("overlay")
    const revealImposter = document.getElementById("impostor-reveal")
    
    const showTimer = () => {
        setTimeout(() => {
            timer.classList.remove("d-none")
        }, 4000);
    }
    
    const countdownStart = () => {
        time.innerText = 9
        setInterval(() => {
            (time.innerText -= 1)

        if ((parseInt(time.innerText)) === 1){
            clearInterval();
            newRoundBtn.submit();
        }
        }, 1000)
    }
    
    const showReady = () => {
        setTimeout(() => {
            ready.classList.remove("d-none")
        },3000)

        showTimer();
        countdownStart();
    }
    
    if(!!overlay){
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

    }

    if(!!ready){ showReady(); }
    if(!!countdown) {
        $( "#countdown" ).load(window.location.href + " #countdown" );
    }
}