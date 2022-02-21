import consumer from "./consumer";

const initRoundCable = () => {
  const inputsContainer = document.getElementById('inputs');
  if (inputsContainer) {
    const id = inputsContainer.dataset.roundId;

    consumer.subscriptions.create({ channel: "RoundChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        inputsContainer.insertAdjacentHTML('beforeend', data)
      },
    });
  }
}

export { initRoundCable };
