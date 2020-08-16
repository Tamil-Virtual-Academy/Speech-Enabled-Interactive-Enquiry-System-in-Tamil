// *******TEXT LOADING FUNCTIONS*************

//Load instructions in the welcome page. Acts as a toggle as well.
var instructionflag = 0;
function loadInstructions() {
  if (instructionflag) {
    document.getElementById("instructionstext").innerHTML="<div></div>"
    instructionflag=0;
  }
  else {

  // USING JQUERY
  $.get("data/instructions.html", function(content){
  document.getElementById("instructionstext").innerHTML=content;
  })
  //************
  instructionflag=1;
  }
}

//targetId - Div which has to be cleared
function clearDiv(targetId) {
  document.getElementById(targetId).innerHTML = ""
}

//execute a php file with jquery
function startenq() {
$.post( "php/startenquiry.php" );
}

function execphp(comm) {
$.post( "shellexecute.php", { command: comm } );
}

function finishplay(comm) {
$.post( "finishplay.php", { command: comm } );
}

function endprocess(comm) {
$.post( "endprocess.php", { command: comm } );
}
//Recieve 'comm' as the argument and then pass it to the shellexecute.php file
//as command, the argument variable that holds comm

//delay before loading a document in a particular div
function delayandload(targetfunction)
{
  //do some things
  // setInterval(loadDoc, 1000); //wait 5 seconds before continuing
  setInterval(targetfunction, 1000);
}

function loadDoc(sourceFile, targetId){
  $.ajax({
    url: sourceFile,
    type: "GET",
    cache: false,
    success: function(result){
            $('#' + targetId).html(result);
            //# is used to select a particular id
    }});
}

// function reload_wave(){
//     $.ajax({
//       url: "wav/wavefile.txt",
//       type: "GET",
//       cache: false,
//       success: function(result){
//             // $('#' + targetId).attr('src', 'wav/1_' + result + '.wav');
//             // $('#' + targetId).html('wav/1_' + result + '.wav');
//             // console.log("wav/1_" + result + ".wav");
//             var wavefile_full = "wav/1_"+result.trim()+".wav";
//             console.log(wavefile_full);
//             var audiotag = '<audio id="synthaudio" src=\"' + wavefile_full + '\"></audio>';
//             console.log(audiotag);
//             // document.getElementById('audioholder').innerHTML = audiotag;
//             $('#audioholder').html(audiotag);
//             // audiotag.load();
//             // <audio id="synthaudio" src="wav/1.wav"></audio>
//       }});
// }

function play_wave(){
    $.ajax({
      url: "wav/wavefile.txt",
      type: "GET",
      cache: false,
      success: function(result){
            var wavefile_full = "wav/1_"+result.trim()+".wav";
            var synth_audio = new Audio(wavefile_full);
            // var synth_audio = document.createElement('synthaudio');
            // synth_audio.src = wavefile_full;
            // synthplay('synthaudio');
            // console.log(sad);
            synth_audio.play();
            synth_audio.onloadedmetadata = function() {
            var audioduration_plus = (synth_audio.duration)*1000;
            setTimeout(function(){ finishplay('210'); }, audioduration_plus);
            };
      }});
}

//USING jquery
function getDoc(sourceFile){
  $.ajax({
    url: sourceFile,
    type: "GET",
    cache: false,
    success: function(result){
            $('#taskathand').html(result);
    }});
}

// *******IMAGE LOADING FUNCTIONS*************

//targetId - Div where the image has to be loaded in the html
//targetImageFile - the place where the source image is located
function imageloader(targetId) {
  var imagegridtablecontent = '<table><tr>';
  imagegridtablecontent += '<td><div id="image_1" class="imagegrid"></div></td>';
  imagegridtablecontent += '<td><div id="image_2" class="imagegrid"></div></td>';
  imagegridtablecontent += '<td><div id="image_3" class="imagegrid"></div></td>';
  imagegridtablecontent += '<td><div id="image_4" class="imagegrid"></div></td>';
  imagegridtablecontent += '<td><div id="image_5" class="imagegrid"></div></td></tr><tr>';
  imagegridtablecontent += '<td><div id="image_6" class="imagegrid"></div></td>';
  imagegridtablecontent += '<td><div id="image_7" class="imagegrid"></div></td>';
  imagegridtablecontent += '<td><div id="image_8" class="imagegrid"></div></td>';
  imagegridtablecontent += '<td><div id="image_9" class="imagegrid"></div></td>';
  imagegridtablecontent += '<td><div id="image_10" class="imagegrid"></div></td></tr></table>';
  document.getElementById('imagegridtable').innerHTML=imagegridtablecontent;
  var xhttp_il = new XMLHttpRequest(); //se - shellexec
  xhttp_il.onreadystatechange = function(){
    if (xhttp_il.readyState == 4 && xhttp_il.status == 200){
       var jsonResponse = JSON.parse(xhttp_il.responseText);
       for (var i = 2; i < jsonResponse.length; i++) {
           var imagefile = jsonResponse[i];
           var ti = i - 1
           var targetIdFunc = targetId + ti;
          document.getElementById(targetIdFunc).innerHTML='<div><img style="display: block;" src="images/cropimages/' + imagefile +'" class="images"><div style="text-align: center;">' + ti + '</div></div>';
          // document.getElementById(targetIdFunc).innerHTML = imagefile;
       }
    }
  };
  // targetimageargument = "php/getimage.php?targetimagefile="+targetImageFile;
  xhttp_il.open("GET", "php/getimage.php");
  xhttp_il.send();
}

function clearimages(){
  document.getElementById('imagegridtable').innerHTML="";
}

// *******DYNAMIC LOADING FUNCTIONS*************
function probeTasker(){
setInterval("taskManager()", 150);
}

function initialize_iterations(){
    clearDiv('question');
    clearDiv('answer');
    clearimages();
}

function taskManager(){
  // console.log("executing taskManager");
  previousTaskVariable = parseInt(document.getElementById("previoustask").innerHTML);
  getDoc('tasker.txt');
  taskVariable = parseInt(document.getElementById("taskathand").innerHTML);

  if (taskVariable != previousTaskVariable) {
  console.log(taskVariable);
  switch(taskVariable) {
    case 101: //Load Question
        loadDoc('question.txt', 'question');
        break;
    case 102: //Load Answer
        loadDoc('answer.txt', 'answer');
        break;
    case 103: //Clear Q and A
        clearDiv('question');
        clearDiv('answer');
        break;
    case 104: //Load Image
        imageloader('image_');
        break;
    case 105: //Clear Image
        clearimages();
        break;
    case 106: //Clear Image
        clearDiv('question');
        break;
    case 107: //Clear Image
        clearDiv('answer');
        break;
    case 201: //Record wave for Recognition
        synthplay('chime');
        $("#chime").on('ended', function(){
            // done playing
            // console.log("donechiming");
        });
        document.getElementById('record').click();
        setTimeout(function(){ document.getElementById('record').click(); }, 3500);
        // setTimeout(function(){ synthplay('chime'); }, 3000);
        break;
    case 202: //Play wave after synthesis
        // reload_wave();
        // synthplay('synthaudio');
        play_wave();
        // $.when(play_wave()).then(function(){console.log("doneplaying");});
        // $("#synthaudio").on('ended', function(){
        //     // done playing
        //     execphp('210');
        // });
        break;

    case 111:
        window.history.back();
        break;

    // case 203:
    //     startenq('203');
    //     break;

    // case 106:
    //     clearInterval(timerHandle);
    //     break;
      }
    document.getElementById("previoustask").innerHTML=taskVariable;
    }
}
