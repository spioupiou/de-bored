export const updateDiv = () => { 
    const instance = document.getElementById("instance")
    const updateThis = document.getElementById("updateThis")

    if (!!updateThis){
        setInterval(() => {
            console.log("refreshing..")
            $( "#updateThis" ).load(window.location.href + " #updateThis" );
    
        }, 1000)
    }

}