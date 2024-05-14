const oddEven = (str) =>{
    let response = ""
    for(i of str){
        const x = i.charCodeAt(0)
        if(x % 2 == 0){
            
            response += i.toUpperCase()
        }
        else{
            
            response += i.toLowerCase()
        }
        
    }
    return response
}

const input = "Pratham"
console.log(oddEven(input))