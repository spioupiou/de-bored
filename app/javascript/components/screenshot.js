import html2canvas from 'html2canvas';

const captureResults = () => {
  const results = document.querySelector("#results");
  const shareBtn = document.querySelector("#share-btn");
  const saveBtn = document.querySelector("#save-logo");

  const takeScreenshot = () => {
    html2canvas(results, {
      backgroundColor: '#035d79cc',
    }).then(canvas => {
      console.log("Screenshot!")
      const image = canvas.toDataURL("image/png", 1.0).replace("image/png", "image/octet-stream");
      if (document.getElementById("screenshot")) {
        document.getElementById("screenshot").src = image;
      }

      if (!!saveBtn) {
        console.log("Save button identified")
        saveBtn.addEventListener('click', () => {
          var link = document.createElement('a');
          link.download = "myresults_debored.png";
          link.href = image;
          link.click();
        })
      }
    });
  }

  if (!!shareBtn) {
    shareBtn.addEventListener('click', takeScreenshot)
  }
}

export { captureResults }
