pragma solidity ^0.8.13;

import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {ILsdRateOracle} from "./interfaces/ILsdRateOracle.sol";


contract LsdRateOracle is ILsdRateOracle ,ReentrancyGuard{
    
    address public lsdToken;
    uint256 public rate;
    address public rateManager;
    constructor() {
         rateManager = msg.sender;
    }
  
   function setRateManager(address _rateManager)  external {
        require(msg.sender == rateManager,"not rateManager");
        rateManager = _rateManager;

    }
    function getLsdRate() view external returns(uint256){
        return rate;
    }
    function setLsdRate(uint256 _rate) external nonReentrant {
        require(msg.sender == rateManager,"only rateManager" );
        require(_rate >= 1e18,"wrong _rate" );
        require(_rate > rate,"wrong _rate" );
         rate = _rate;
        emit LsdRateSeted(lsdToken,_rate);
    }

    
}
