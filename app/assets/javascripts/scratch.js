const toBase64 = (file) =>
  new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = (error) => reject(error);
  });

const processOptiic = (fileInput) => {
  const ocrArea = document.querySelector("#optiic-area");
  let optiic = new Optiic({
    apiKey: "AUXNtwXNiw7kMCnwTWqs1RTAVtT1ozskEQDJu9QZhwGZ",
  });
  ocrArea.value = "Loading...";

  optiic
    .process({
      url: fileInput,
    })
    .then((response) => {
      console.log({ optiicResponse: response });
      ocrArea.value = response?.text;
    })
    .catch((error) => {
      console.log({ error });
      ocrArea.value = error;
    });
};

const processOCRSpace = (base64Image) => {
  let formData = new FormData();
  formData.append("language", "eng");
  formData.append("isOverlayRequired", "false");
  formData.append("base64Image", base64Image);
  formData.append("iscreatesearchablepdf", "false");
  formData.append("issearchablepdfhidetextlayer", "false");
  const ocrSpace = document.querySelector("#ocr-area");

  ocrSpace.value = "Loading...";

  fetch("https://api.ocr.space/parse/image", {
    method: "POST",
    headers: new Headers({ apikey: "db6187261888957" }),
    body: formData,
  })
    .then((res) => res.json())
    .then((res) => {
      console.log({ res });
      if (res.ParsedResults) {
        let text = "";
        res.ParsedResults.forEach((item) => {
          text = text + item.ParsedText;
        });
        ocrSpace.value = text;
      }
    })
    .catch((err) => {
      console.log({ err });
      ocrSpace.value = err;
    });
};

const startScratch = () => {
  console.log("Starting scratch");
  const form = document.querySelector("form");
  const ocrBtn = document.querySelector("#ocr-btn");
  const fileInput = form.querySelector('input[type="file"]');

  ocrBtn.addEventListener("click", async (e) => {
    e.preventDefault();
    if (fileInput.files.length == 0) {
      alert("Please input an image");
      return;
    }

    console.log({
      files: await toBase64(fileInput.files[0]),
      input: form.querySelector('input[type="file"]'),
    });
    processOptiic(fileInput);
    processOCRSpace(await toBase64(fileInput.files[0]));
  });
};
