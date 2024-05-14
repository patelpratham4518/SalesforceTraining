const conAsc = (str) =>{
    let res = []
    let consecutive = ""
    for(let i=0 ; i<str.length; i++){
        const current = Number(str[i])
        const next = Number(str[i+1])
        if(current+1 == next){
            consecutive += str[i]
        }
        else{
            consecutive += str[i]
            if(consecutive.length>1){
                res.push(consecutive)
            }
            consecutive = ""
        }
    }
    return res
}


const x = "1235467896"
console.log(conAsc(x))