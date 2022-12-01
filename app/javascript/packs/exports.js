function changeRequestedAlbum(albumCode){

    valueToChange = document.getElementById("exports_requestedAlbums").value;

    if (valueToChange.charAt(0) == ','){
      valueToChange = valueToChange.substring(1)
    }

    if (valueToChange.includes(albumCode)){
      valueToChange = document.getElementById("exports_requestedAlbums").value.replace(albumCode,"")

    }else{
     valueToChange =  valueToChange + "," + albumCode

    }
    
    if (valueToChange.charAt(0) == ','){
      valueToChange = valueToChange.substring(1)
    }

    valueToChange = valueToChange.replace(",,",",")

    document.getElementById("exports_requestedAlbums").value = valueToChange

  }