const frm = document.querySelector("form")
const resp1 = document.querySelector("h3")
const resp2 = document.querySelector("h4")

frm.addEventListener("submit", (e)=>{
    e.preventDefault()
    const valor = Number(frm.inValor.value)
    let troco = 0
    if(valor < 1){
        resp1.innerText = "Valor insuficiente"
    } else if(/*valor >= 1 && */ valor < 1.75){
        resp1.innerText = "Permitido 30 min"
        troco = valor-1
    } else if(valor < 3){
        resp1.innerText = "Permitido 60 min"
        troco = valor - 1.75
    } else {
        resp1.innerText = "Permitido 120 min"
        troco = valor - 3
    }
    resp2.innerText = `Troco de R$ ${troco.toFixed(2)}`
})
