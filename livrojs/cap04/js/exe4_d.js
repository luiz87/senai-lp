const frm = document.querySelector("form")
const resp1 = document.querySelector("#out01")
const resp2 = document.querySelector("#out02")

frm.addEventListener("submit", (e) => {
    e.preventDefault()
    const ladoA = Number(frm.inLadoA.value)
    const ladoB = Number(frm.inLadoB.value)
    const ladoC = Number(frm.inLadoC.value)

    if (ladoA > (ladoB + ladoC) || ladoB > (ladoA + ladoC) || ladoC > (ladoA + ladoB)) {
        resp1.innerText = "Não pode formar uma triangulo"
    } else {
        resp1.innerText = "Pode formar uma triangulo"
        if (ladoA == ladoB && ladoA == ladoC) {
            resp2.innerText = "Tipo do triango Equilátero"
        } else if (ladoA != ladoB && ladoA != ladoC && ladoB != ladoC) {
            resp2.innerText = "Tipo do triango Escaleno"
        } else {
            resp2.innerText = "Tipo do triango Isósceles"
        }
    }
})