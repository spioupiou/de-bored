import consumer from "./consumer";
const initResultCable = () => {
    
    consumer.subscriptions.create({ channel: "ResultChannel", id :result_id }, {
        connected() {
          console.log("connected")
        },
  
        disconnected() {
          console.log("disconnected");
        },
  
        received(data) {
          console.log(data)
        }
      });

}