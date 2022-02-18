import consumer from "./consumer";

const initInstanceChannel = () => {

  const instanceContainer = document.getElementById("instance")
  // if (instanceContainer === null){
  //   consumer.subscriptions.remove({ channel: "InstanceChannel" })
  //   console.log("unsub")
  // }

  if (instanceContainer) {
    const playerCount = document.getElementById("player-count")
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
        console.log(`${player_name} has left the Instance Channel ${instance_id}`);
      },

      received(data) {
        console.log("InstanceChannel received", data);
        const notice = `<div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>${data.player_list}</strong> has joined the lobby <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button></div>`
        if (data.player_list){
          playerList.insertAdjacentHTML(
            "beforeend", 
            `<div class="card shadow-sm p-3 bg-white rounded">${data.player_list}</div>`
            )
          playerCount.innerHTML = data.player_count
            instanceContainer.insertAdjacentHTML("beforebegin", notice)
        }
        if (data.question_page){
          instanceContainer.innerHTML = data.question_page;
        }
      }
    });
  }
}

export { initInstanceChannel };
