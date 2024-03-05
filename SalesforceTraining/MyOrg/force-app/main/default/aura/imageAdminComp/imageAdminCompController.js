({
    myAction : function(component, event, helper) {

    },

    displayImage : function(component , event , helper){
        console.log("display called");
        let url = document.querySelector("#url").value 
        let backgroundColor = document.querySelector("#backgroundColor").value 
        let description = document.querySelector("#description").value 
        let fontColor = document.querySelector("#fontColor").value 
        let fontSize = document.querySelector("#fontSize").value 
        
        let output = document.getElementById("output")
        output.style.backgroundColor = backgroundColor
        output.innerHTML = ` <img src="${url}" alt="Invalid Url"/>
        <output style="font-size: ${fontSize}px;color:${fontColor};" >${description}</output>`
        component.set("v.input",false)
        component.set("v.output",true)
    }
})
