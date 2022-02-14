import consumer from "./consumer";

const initInstanceChannel = () => {
  console.log("Connection complete");
  const instanceContainer = document.getElementById("instance")
  if (instanceContainer) {
    const id = instanceContainer.dataset.instanceId;
    console.log("Instance id: ", id);

    consumer.subscriptions.create({ channel: "InstanceChannel" }, {
      connected() {
        console.log("InstanceChannel connected");
      },

      disconnected() {
        console.log("InstanceChannel disconnected");
      },

      received(data) {
        console.log("InstanceChannel received", data);
      }
    });
  }
}

export { initInstanceChannel };
