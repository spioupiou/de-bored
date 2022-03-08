export const showWinner = () => {
    const winnerSection = document.getElementById("winner-section");
    const returnBtn = document.getElementById("return-screen");
    
    
    if((!!winnerSection) && (!!returnBtn)){
        const announce = winnerSection.dataset.announceWinner;
        const impostor = winnerSection.dataset.winnerId;
        let announcement = ""
        if(announce === "LOSE") { 
            announcement = `<strong style="color:red;">LOST</strong>` 
        }
        else{
            announcement = `<strong style="color:#14e914;">WON</strong>`
        }

        returnBtn.addEventListener("click", (e) => {
            winnerSection.innerHTML = `<h4>${impostor} was the Impostor</h4>
            <h4>You ${announcement} the game!</h4>`
        })
    }


}