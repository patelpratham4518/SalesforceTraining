
const circle1 = document.getElementById("circle1");
const circle2 = document.getElementById("circle2");

function drag({movementX , movementY}){

    let style = window.getComputedStyle(circle1);
    let left = parseInt(style.left);
    let top = parseInt(style.top);
    circle1.style.left = `${left + movementX}px`
    circle1.style.top = `${top + movementY}px`
    

    
}
circle1.addEventListener("mousedown",()=>{
    circle1.addEventListener("mousemove",drag)
})

document.addEventListener("mouseup",()=>{
    circle1.removeEventListener("mousemove",drag) 


    let style1 = window.getComputedStyle(circle1);
    let left1 = parseInt(style1.left);
    let top1 = parseInt(style1.top);
    let style2 = window.getComputedStyle(circle2);
    let left2 = parseInt(style2.left);
    let top2 = parseInt(style2.top);
    if((left1>left2-100)&&(top1>top2-100)){
        circle1.style.height = "150px"
        circle1.style.width = "150px"
        circle1.style.cursor = "auto"
        circle1.style.top = "275px"  
        // circle1.style.top += "25px"  
        circle1.style.left = "1225px"
        // circle1.style.left += "25px"  
        circle1.removeEventListener("mousedown",()=>{
            circle1.addEventListener("mousemove",drag)
        })
    }
})





 