import fs from "fs"
const firstreoccur = (str) =>{
    let prev = ""
    for(let i=0; i<str.length;i++){
        if(prev.includes(str[i])){
            // console.log(str[i])
            const letter = str[i]
            const obj = { [str[i]]: [i,str.indexOf(str[i])]}
            return obj
            break
        }
        prev += str[i]
    }
}

// const redaing = (str) =>{
//     let data = fs.readFileSync(str)
//     console.log(data)
// }

const gettingReoccurences = (data) =>{
    const x = data.split(" ")
    for(i of x){
        console.log(firstreoccur(i))
    }
}

gettingReoccurences("“BTEJHBERSD” “JPDETRETXD”")

