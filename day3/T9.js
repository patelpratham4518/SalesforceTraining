const capitalFront = (str) => {
    let capital = ""
    let small = ""
    for(i of str){
        if(i.toUpperCase() == i){
            capital += i
        }
        else{
            small += i
        }
    }
    const response = capital + small
    return response
}

console.log(capitalFront("PaTelPrAThaM"))


