pragma solidity ^0.4.21;

contract Eleccion {
    
    struct Candidato {
        string nombre;
        uint cantVotos;
    }
    
    struct Votante {
        bool autorizado;
        bool yaVoto;
        uint voto;
    }
    
    //Aca podemos tener problemas
    address public owner;
    string public nombreDeEleccion;

    mapping(address => Votante) public votantes;
    Candidato[] public candidatos;
    uint public cantTotalVotos;

    modifier esElOwner() {
        require(msg.sender == owner);
        //Si la condición se cumple, se ejecuta el resto de la funcion
        _;
    }
    
    constructor(string memory _nombreEleccion) public {
        //Establezco el dueño a traves de la var global "msg "
        owner = msg.sender;
        nombreDeEleccion = _nombreEleccion;
    }
    
    //pre: debe ser el owner
    //Se chequea si es el owner para agregar un candidato con el modifier tipo assert
    function agregarCandidato(string memory _nombreCandidato) esElOwner public {
        candidatos.push(Candidato(_nombreCandidato, 0));
    }
    
    // function getCantidadDeCandidatos() public view returns(uint) {
    //     returns candidatos.length;
    // }
    
    function autorizado(address _persona) esElOwner public {
        votantes[_persona].autorizado = true;
    }
    
    function votar(uint _idVoto) public {
        //Me fijo que no haya votado
        require(!votantes[msg.sender].yaVoto);
        //Me fijo que esté autorizado
        require(votantes[msg.sender].autorizado);
        
        votantes[msg.sender].voto = _idVoto;
        votantes[msg.sender].yaVoto = true;
        
        candidatos[_idVoto].cantVotos += 1;
        cantTotalVotos +=1;
    }
    
    function finalizarEleccion() esElOwner public {
        selfdestruct(owner);
    }
        
}
