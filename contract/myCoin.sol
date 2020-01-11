pragma solidity ^0.5.1;

contract myCoin {
  /*状態変数の宣言*/
  string public name;         /*tokenの名前*/
  string public symbol;       /*tokenの単位*/
  uint8 public decimals;      /*小数点以下の桁数*/
  uint256 public totalSupply; /*tokenの総量*/
  mapping(address => uint256) public balanceOf; /*各アドレスの残高*/
  mapping(uint256 => string) public date;
  uint256 public transferId;


  /*イベント通知*/
  event Transfer(address indexed from, address indexed to, uint256 value);

  /*コンストラクタ*/
  constructor(uint256 _supply, string memory _name, string memory _symbol, uint8 _decimals)public{
    balanceOf[msg.sender] = _supply;
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    totalSupply = _supply;
    transferId = 0;
  }

  /*送金*/
  function transfer(address _to, uint256 _value, string memory _date) public {
    /*不正送金チェック*/
    if (balanceOf[msg.sender] < _value) revert();
    if (balanceOf[_to] + _value < balanceOf[_to]) revert();

    /*送金アドレスと受信アドレスの残高を更新*/
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;

    transferId = transferId + 1;
    date[transferId] = _date;
    /*イベント通知*/
    emit Transfer(msg.sender, _to, _value);
  }

  function getLog() public {
    return date;
  }

  function getLogNum() public {
    return transferId;
  }
}
