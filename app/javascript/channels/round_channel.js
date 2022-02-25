import consumer from "./consumer";

const initRoundCable = () => {
  const inputsContainer = document.getElementById('inputs');
  if (inputsContainer) {
    const id = inputsContainer.dataset.roundId;

    consumer.subscriptions.create({ channel: "RoundChannel", id: id }, {
      connected(){
        console.log("connected to round channel")
      },
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        if (data.head == 303 && data.path) {
          window.location.pathname = data.path;
          console.log("success")
        }else{
          inputsContainer.innerHTML = data;

        }
      },
    });
  }
}

export { initRoundCable };
