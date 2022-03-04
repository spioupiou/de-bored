import consumer from "./consumer";
const initResultCable = () => {
  const resultContainer = document.getElementById("result") 

  if(resultContainer){
    const result_id = resultContainer.dataset.resultId;

      consumer.subscriptions.create({ channel: "ResultChannel", id :result_id }, {
          connected() {
            console.log(`connected to result channel ${result_id}`)
          },
    
          disconnected() {
            console.log("disconnected");
          },
    
          received(data) {
            console.log(data)
          }
        });
    }
}

export { initResultCable };