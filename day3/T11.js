const getOne = (...args) =>{
    let sum = 0
    for(i of args){
        sum += i
    }
    while(sum.toString().length != 1){
        sum = sum.toString().split("")
        let mul = 1
        for(i of sum){
            mul *= Number(i)
        }
        sum = mul
    }
    console.log(sum)

}
getOne(16,28)