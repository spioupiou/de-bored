import consumer from "./consumer";

const initInstanceChannel = () => {
  const instanceContainer = document.getElementById("instance")
  const questionContainer = document.getElementById("waiting-page")

  if (instanceContainer) {
    const id = instanceContainer.dataset.instanceId;
    const player = instanceContainer.dataset.playerName
    const playerId= instanceContainer.dataset.playerId;

    consumer.subscriptions.create({ channel: "InstanceChannel", id :id }, {
      connected() {
        console.log(`Welcome ${player}, id:${playerId} to Instance Channel ${id}`);
      },

      disconnected() {
        console.log("InstanceChannel disconnected");
      },

      received(data) {
        console.log("InstanceChannel received", data);
        questionContainer.innerHTML = data;
      }
    });
  }
}

export { initInstanceChannel };
