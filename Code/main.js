var gateway = `ws://192.168.4.1/ws`;

window.addEventListener('load', onLoad);
function initWebSocket() {
    console.log('Trying to open a WebSocket connection...');
    // websocket = new WebSocket(gateway);
    websocket = new WebSocket(gateway);
    websocket.onopen = onOpen;
    websocket.onclose = onClose;
    websocket.onmessage = onMessage;
}
function onOpen(event) {
    console.log('Connection opened');
}
function onClose(event) {
    console.log('Connection closed');
    setTimeout(initWebSocket, 100);
}
function onMessage(event) {
  
}
function onLoad(event) {
    initWebSocket();
    initButton();
}
function initButton() {
    document.getElementById("buttonstart").addEventListener("click", openPageControlller);
}
function openPageControlller(){
    document.getElementById("PageController").style.display = "block";
    document.getElementById("PageIntroduction").style.display = "none";
    document.getElementById("PageLogin").style.display = "none";
}
  
