document.getElementById("circle-1").style.backgroundColor = "blue"
document.getElementById("circle-1").style.height = "200px"
document.getElementById("circle-1").style.width = "200px"
document.getElementById("circle-2").style.backgroundColor = "red"


let counter = 1
document.addEventListener("dragenter", function(event) {
    if ( event.target.className == "dropzone" ) {
        let dropzoneid = "circle-" + counter.toString() 
        // let dropzoneid = "circle-1" 
        let draggableid = "circle-" + (counter+1).toString()
        // let dropzone = document.getElementById("circle-1")
        // let draggable = document.getElementById("circle-2")
        let dropzone = document.getElementById(dropzoneid)
        let draggable = document.getElementById(draggableid)
        let height = parseInt(window.getComputedStyle(dropzone).height)
        let width = parseInt(window.getComputedStyle(dropzone).width)
    
        height -=20
        width -= 20 

        console.log(counter)
        console.log(draggableid)

        draggable.style.height = `${height}px`
        draggable.style.width = `${width}px`
        //new

        draggable.style.marginLeft = "10px"
        draggable.style.marginTop = "10px"

        //new
        draggable.draggable = false
        dropzone.appendChild(draggable)
    console.log("dragenter")
    let newCircle = document.createElement("span")
    newCircle.className = "draggable"
    newCircle.id = "circle-" + (counter+2).toString()
    
    newCircle.style.backgroundColor = "#" + Math.floor(Math.random()*16777215).toString(16)
    newCircle.draggable = true
    document.body.appendChild(newCircle)
    counter+=1
    // draggable.className = "dropzone"
    // dropzone.className = "none"
    }
  });
  