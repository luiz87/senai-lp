function calcular(){
    
    const nome = document.getElementById("inNome").value;
    const masculino = document.getElementById("inMasculino").checked;
    const altura = document.getElementById("inAltura").value;
    
    let peso;

    if(masculino){
        peso = 22 * Math.pow(altura, 2)
    }else{
        peso = 21 * Math.pow(altura, 2)
    }

    document.querySelector("h3").innerText = `Peso ideal ${peso.toFixed(2)}`;

    return false; // vai impedir o refresh da página equivalente ao e.preventDefault()

}