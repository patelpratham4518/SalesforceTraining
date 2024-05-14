const sortASCII = (str) =>{
    let arr = str.split("")
    arr.sort()
    let ASCII = []
    // for(let i=0;i<arr.length;i++){
    //     ASCII.push(arr[i].charCodeAt(0))
    // }
    // console.log(ASCII)
    return arr.join("")
}
console.log(sortASCII("aaPtrmh"))