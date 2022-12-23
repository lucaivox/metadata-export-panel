//add checked albums in table to hidden form to send request
window.changeRequestedAlbum = function (albumCode){

    valueToChange = document.getElementById("exports_requested_albums").value;

    if (valueToChange.charAt(0) == ','){
      valueToChange = valueToChange.substring(1)
    }

    if (valueToChange.includes(albumCode)){
      valueToChange = document.getElementById("exports_requested_albums").value.replace(albumCode,"")

    }else{
     valueToChange =  valueToChange + "," + albumCode

    }
    
    if (valueToChange.charAt(0) == ','){
      valueToChange = valueToChange.substring(1)
    }      
    if (valueToChange.charAt(valueToChange.length-1) == ','){
      valueToChange = valueToChange.slice(0,-1)
    }

    valueToChange = valueToChange.replace(",,",",")

    document.getElementById("exports_requested_albums").value = valueToChange

    //add here change status check for select all

    if (document.getElementById("exports_requested_albums").value != "" && document.getElementById("selectAllCheckbox").checked == false ){
        document.getElementById("selectAllCheckbox").indeterminate = true
    }
    else{
       document.getElementById("selectAllCheckbox").indeterminate = false
    }

}


//change the export type in hidden form based on select on top page
window.exportType = function (){
    valueToChange = document.getElementById("select_export_type").value;
    document.getElementById("exports_export_type").value = valueToChange

}

//use the select all checkbox
window.selectAllCheckboxes = function(){

    //first thing, set requested album in form as empty
    document.getElementById("exports_requested_albums").value = ""
    
    //then for each td marck checkboxes
    var cbs = document.getElementsByTagName('input');
    for(var i=6; i < cbs.length; i++) {
      if(cbs[i].type == 'checkbox') {

        if (document.getElementById("selectAllCheckbox").checked == true){
            console.log("checked false")
            changeRequestedAlbum(cbs[i].name)
            cbs[i].checked = true;
            
        }
        if (document.getElementById("selectAllCheckbox").checked == false){
            console.log("checked true")
            document.getElementById("selectAllCheckbox").indeterminate = false
            cbs[i].checked = false;
        }
      }
    }
}

