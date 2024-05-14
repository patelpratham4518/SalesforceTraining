const maxMin = (str) =>{
    let arr = str.split(" ")
    let max = Number(arr[0])
    let min = Number(arr[0])
    for(i of arr){
        x = Number(i)
        if(max < x){
            max = x
        }
        if(min > x){
            min = x
        }
    }
    
    return [max,min].join(" ")
}


const input = "1 45 18 63 10"
console.log(maxMin(input))

