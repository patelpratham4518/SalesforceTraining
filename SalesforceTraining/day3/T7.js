const removeLeading = (str) =>{
    let flag = false
    let response = ""
    for(let i=0 ; i<str.length ; i++){
        if(str[i]!="0"){
            flag = true
        }
        if(flag == true){
            response += str[i]
        }
    }
    return response
}

const removeLeadingTrailing = (str) =>{

    const leading  = str.split(".")[0]
    const trailing = str.split(".")[1]
    
    const responseLeading = removeLeading(leading)

    const trailingReverse = trailing.split("").reverse().join("")
    const responseTrailing = removeLeading(trailingReverse).split("").reverse().join("")
    console.log(responseTrailing)

    const response = responseLeading + "." + responseTrailing
    return response

}



console.log(removeLeadingTrailing("00540.603400"))