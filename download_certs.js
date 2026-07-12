const fs = require('fs');
const https = require('https');

const files = [
  { id: '1X7yXdaVNXGFLT2iTJSseG17XAiLGlpO5', name: 'cert1.pdf' },
  { id: '1lWfR2xPrttjGaOVQpx7vckjM3DpkYoUV', name: 'cert2.jpg' },
  { id: '1Zrgs2bCMOmnA4fUKgc00uo_NlX4GJyBm', name: 'cert3.png' },
  { id: '1Mkq4Ne8eisxRzW5CUJ2PZ09ROGHTJ34z', name: 'cert4.pdf' },
  { id: '1xMeVW3PrSzveUfxoJ8RZ6PblHTdXU5SE', name: 'cert5.pdf' },
  { id: '1-srSE-l2aPNCKvQNUulE52G0Rcw8gpNi', name: 'cert6.pdf' },
  { id: '1bW-LgWlR-jN1yF074G2Hj46cK9c3Tj0E', name: 'cert7.jpg' }
];

files.forEach(file => {
  const url = 'https://drive.google.com/uc?export=download&id=' + file.id;
  https.get(url, (res) => {
    if (res.statusCode === 302 || res.statusCode === 303) {
      https.get(res.headers.location, (res2) => {
        const path = `images/certificates/${file.name}`;
        const writeStream = fs.createWriteStream(path);
        res2.pipe(writeStream);
        writeStream.on('finish', () => {
          writeStream.close();
          console.log('Downloaded', file.name);
        });
      });
    } else {
      const path = `images/certificates/${file.name}`;
      const writeStream = fs.createWriteStream(path);
      res.pipe(writeStream);
      writeStream.on('finish', () => {
        writeStream.close();
        console.log('Downloaded', file.name);
      });
    }
  });
});
