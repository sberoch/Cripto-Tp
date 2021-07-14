pragma solidity ^0.4.21;

/*
Como usar:
1. registrarse con algun nombre usando registrarJugador
2. elegir una jugada usando jugar(numeroElemento, miNumeroDeJugador) (si soy el jugador 0 y quiero usar TIJERA: jugar(0, 3))
3. Hacer lo mismo pero con otra address (cambiarla la account arriba de todo, entre gas limit y environment)
4. ver ganador con verGanador
*/

contract PiedraPapelTijera {
    
    enum Elemento { DESCONOCIDO, PIEDRA, PAPEL, TIJERA }
    
    struct Jugador {
        string nombre;
        Elemento jugada;
        address dir_jugador;
    }
    
    address public owner;
    
    // TODO: cambiar esta variable a private o internal
    Jugador[] public jugadores;
    int[4][4] public jugadasPosibles;
    
    constructor() public {
        //Establezco el dueño a traves de la var global "msg "
        owner = msg.sender;
        
        // TODO: chequear si ta bien xd
        jugadasPosibles[0] = [-1, -1, -1, -1];
        jugadasPosibles[1] = [-1, -1, 1, 0];
        jugadasPosibles[2] = [-1, 0, -1, 1];
        jugadasPosibles[3] = [-1, 1, 0, -1];
    }
    
    function registrarJugador(string memory _nombreCandidato) public {
        require(jugadores.length < 2);
        // require(jugadores[msg.sender].nombre == "");     TODO: reescribir esto con keccak256
        require(keccak256(abi.encodePacked("")) != keccak256(abi.encodePacked(_nombreCandidato)));
        
        jugadores.push(Jugador(_nombreCandidato, Elemento.DESCONOCIDO, msg.sender));
    }
    
    
    // TODO debe faltar algun require
    function jugar(Elemento jugada, uint numeroJugador) public {
        require(jugadores[numeroJugador].dir_jugador == msg.sender);
        require(keccak256(abi.encodePacked(jugadores[numeroJugador].nombre)) != keccak256(abi.encodePacked("")));
        require(jugadores[numeroJugador].jugada == Elemento.DESCONOCIDO);
        require(jugada != Elemento.DESCONOCIDO);
        
        jugadores[numeroJugador].jugada = jugada;
    }
    
    // TODO la interfaz no es clara
    function verGanador() view public returns(string, int) {
        if (jugadores[0].jugada == Elemento.DESCONOCIDO || jugadores[1].jugada == Elemento.DESCONOCIDO) {
            return ("No termino el juego", -1);
        } else {
            return ("Gano jugador ", calcularGanador(jugadores[0].jugada, jugadores[1].jugada));
        }
    }
    
    function calcularGanador(Elemento jugadaA, Elemento jugadaB) view private returns(int) {
        return jugadasPosibles[uint(jugadaA)][uint(jugadaB)];
    }
    
    function finalizarJuego() public {
        selfdestruct(owner);
    }
        
}
