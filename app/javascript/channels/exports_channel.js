import consumer from "./consumer"

consumer.subscriptions.create("ExportsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to ExportsChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected from ExportsChannel")
  },

  received(data) { 
    // Called when there's incoming data on the websocket for this channel
    console.log(data)

    var loader

    if (data.loader==true) {

      console.log(data.loader)
      console.log(data.album)
      console.log(data.current)
      console.log(data.total)
      //make sure spinner is hidden
      // loader = document.getElementById("spinner-container")
      // loader.style.display = "none"

      //add current exporting album
      loader = document.getElementById("spinner-text")
      loader.innerHTML = "<b>Exporting album " + data.album + "</b>"

      //add what album is currently exporting on queue
      loader = document.getElementById("spinner-text2")
      loader.innerHTML = "Exporting album " + (data.current + 1) + " of " + data.total

      //display spinner
      loader = document.getElementById("spinner-container")
      loader.style.display = "block"
    }
    else{

      //hide spinner
      loader = document.getElementById("spinner-container")
      loader.style.display = "none"
    }





  }
});
