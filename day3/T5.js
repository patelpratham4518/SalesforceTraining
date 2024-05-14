const largeswap = (num) =>{
    const numString = num.toString()
    if(numString.length == 2){
        const swap = Number(numString[1]+numString[0])
        return num<swap
    }
    else{
        console.log("enter valid number")
    }
}
const num = 43
console.log(largeswap(num))