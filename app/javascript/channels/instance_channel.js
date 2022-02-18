import consumer from "./consumer";

const initInstanceChannel = () => {
  const instanceContainer = document.getElementById("instance")

  if (instanceContainer) {
    const instance_id = instanceContainer.dataset.instanceId;
    const host_id = instanceContainer.dataset.hostId;
    const host_name = instanceContainer.dataset.hostName;
    const player_id = instanceContainer.dataset.playerId
    const player_name = instanceContainer.dataset.playerName

    consumer.subscriptions.create({ channel: "InstanceChannel", id :instance_id }, {
      connected() {
        console.log(`PLAYER ID: ${player_id} HOST ID: ${host_id} PLAYER NAME: ${player_name} HOST NAME: ${host_name}`)
      },

      disconnected() {
        console.log("InstanceChannel disconnected");
        `${player_name} has left the Instance Channel ${instance_id}`
      },

      received(data) {
        console.log("InstanceChannel received", data);
        instanceContainer.innerHTML = data;
      }
    });
  }
}

export { initInstanceChannel };
