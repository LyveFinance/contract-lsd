pragma solidity ^0.8.13;

import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {ILsdRateOracle} from "./interfaces/ILsdRateOracle.sol";


contract LsdRateOracle is ILsdRateOracle ,ReentrancyGuard{
    
    address public lsdToken;
    uint256 public rate;
    address public governor;
    mapping (address => bool) public rateManager;
    constructor(address _lsdToken,address _governor) {
        lsdToken = _lsdToken;
        governor = _governor;
        rateManager[_governor] = true;
    }
  
   function setRateManager(address _rateManager)  external returns(uint256){
        require(msg.sender == governor,"not governor");
        rateManager[_rateManager] = true;
    }
    function getLsdRate() view external returns(uint256){
        return rate;
    }
    function setLsdRate(uint256 _rate) external nonReentrant {
        require(rateManager[msg.sender],"only rateManager" );
        require(_rate >= 1e18,"wrong _rate" );
        require(_rate > rate,"wrong _rate" );
         rate = _rate;
        emit LsdRateSeted(lsdToken,_rate);
    }

    
}
