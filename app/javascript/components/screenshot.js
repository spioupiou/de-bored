import html2canvas from 'html2canvas';

const captureResults = () => {
  const results = document.querySelector("#result");
  const saveBtn = document.querySelector("#download");

  function dataURLtoBlob(dataURL) {
    // Decode the dataURL
    var binary = atob(dataURL.split(',')[1]);
    // Create 8-bit unsigned array
    var array = [];
    for (var i = 0; i < binary.length; i++) {
      array.push(binary.charCodeAt(i));
    }
    // Return our Blob object
    return new Blob([new Uint8Array(array)], { type: 'image/png' });
  }

  const takeScreenshot = () => {
    html2canvas(results, {
      backgroundColor: '#035d79cc',
    }).then(canvas => {
      console.log("Screenshot!")
      const image = canvas.toDataURL("image/png", 1.0).replace("image/png", "image/octet-stream");
      // Insert image in element
      // if (document.getElementById("screenshot")) {
      //   document.getElementById("screenshot").src = image;
      // }

      // Find a way to save in base64 image
      var file = dataURLtoBlob(image)

      var fd = new FormData();
      // Append our Canvas image file to the form data
      fd.append("image", file);
      // And send it
      $.ajax({
        url: "/screenshot",
        type: "POST",
        data: fd,
        processData: false,
        contentType: false,
      });

      // Download the image
      const link = document.createElement('a');
      link.download = "myresults_debored.png";
      link.href = image;
      link.click();
    });
  }

  if (!!saveBtn) {
    saveBtn.addEventListener('click', takeScreenshot)
  }
}

export { captureResults }
