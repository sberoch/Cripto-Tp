pragma solidity ^0.4.21;

/*
Como usar:
1. Con una cuenta seleccionada, ingresar jugada JugadorA
2. Hacer lo mismo pero con otra address (cambiarla la account arriba de todo, entre gas limit y environment)
3. ver ganador con verGanador

En el medio, puede usarse la consola de remix para inspeccionar la jugada del jugador A con:
web3.eth.getStorageAt('<addres contrato>', 0);
*/

contract NumeroMasAltoGana {
    
    Jugador[2] internal jugadores;
    
    struct Jugador {
        uint256 numeroElegido;
        address dir_jugador;
    }
    
    address public owner;

    constructor() public {
        //Establezco el dueño a traves de la var global "msg "
        owner = msg.sender;
    }
    
    function jugadaJugadorA(uint256 jugada) public {
        require(jugadores[0].dir_jugador == 0x0);

        jugadores[0].dir_jugador = msg.sender;
        jugadores[0].numeroElegido = jugada;
    }
    
    function jugadaJugadorB(uint256 jugada) public {
        require(jugadores[1].dir_jugador == 0x0);
        
        jugadores[1].dir_jugador = msg.sender;
        jugadores[1].numeroElegido = jugada;
    }
    
    // TODO la interfaz no es clara
    function verGanador() view public returns(string, uint256, uint256) {
        if (jugadores[0].dir_jugador == 0x0 || jugadores[1].dir_jugador == 0x0) {
            return ("No termino el juego", 0, 0);
        } else {
            return ("Numeros elegidos: ", jugadores[0].numeroElegido, jugadores[1].numeroElegido);
        }
    }
    
    function finalizarJuego() public {
        selfdestruct(owner);
    }
        
}
