import consumer from "./consumer";

const initInstanceChannel = () => {
  const instanceContainer = document.getElementById("instance")

  if (instanceContainer) {
    const playerList = document.getElementById("player-list")
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
        // to redirect all subscribers except host after clicking start game, host is redirected via controller
        if (data.head == 302 && data.path) {
          window.location.pathname = data.path;
        }
        console.log("InstanceChannel received", data);
        const notice_player =
          `<div class="alert alert-success alert-dismissible fade show" role="alert">
          <strong>${data.user}</strong> has joined the lobby <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span></button></div>`
        if (data.waiting_page){
          playerList.innerHTML = data.page[0];
          instanceContainer.insertAdjacentHTML("beforebegin", notice_player);
        }
      }
    });
  }
}

export { initInstanceChannel };
