import Rails from "@rails/ujs";
import html2canvas from 'html2canvas';


const downloadResults = () => {
  const results = document.querySelector("#result");
  const saveBtn = document.querySelector("#download");

  function dataURLtoBlob(dataURL) {
    // Decode the dataURL
    let binary = atob(dataURL.split(',')[1]);
    // Create 8-bit unsigned array
    let array = [];
    for (let i = 0; i < binary.length; i++) {
      array.push(binary.charCodeAt(i));
    }
    // Return our Blob object
    return new Blob([new Uint8Array(array)], { type: 'image/png' });
  }

  const takeScreenshot = () => {
    html2canvas(results, {
      backgroundColor: '#035d79cc',
      allowTaint: true,
      useCORS: true,
      proxy: 'server.js',
    }).then(canvas => {
      console.log("Screenshot!")
      const image = canvas.toDataURL("image/png", 1.0).replace("image/png", "image/octet-stream");
      // Insert image in element
      // if (document.getElementById("screenshot")) {
      //   document.getElementById("screenshot").src = image;
      // }

      // Save in base64 image
      let file = dataURLtoBlob(image)

      let fd = new FormData();
      // Append our Canvas image file to the form data
      fd.append("image", file);

      // Append the result number to the form data
      let url = window.location.href;
      const resultId = url.split("/").pop();
      fd.append("result", resultId)

      // And send it
      Rails.ajax({
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

const tweetResults = () => {
  const results = document.querySelector('#result');
  let twitterBtn = document.querySelector('#twitter');

  const currentPageUrl = window.location.href;

  const makeTweetableUrl = (text, pageUrl) => {
    const tweetableText = "https://twitter.com/intent/tweet?url=" + pageUrl + "&text=" + encodeURIComponent(text);
    return tweetableText;
  }

  if (!!twitterBtn) {
    const title = results.querySelector('h1');
    let tweetableUrl = makeTweetableUrl(title.innerText, currentPageUrl);
    twitterBtn.setAttribute("href", tweetableUrl);

    // Open the popup
    $(twitterBtn).click(function (e) {
      e.preventDefault();
      var href = $(this).attr('href');
      window.open(href, "Twitter", "height=400,width=300,resizable=1");
    });
  }
}

export { downloadResults };
export { tweetResults };
