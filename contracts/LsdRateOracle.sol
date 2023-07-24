pragma solidity ^0.8.19;

import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {ILsdRateOracle} from "./interfaces/ILsdRateOracle.sol";


contract LsdRateOracle is ILsdRateOracle ,ReentrancyGuard{
    mapping(address => uint256) private rates; 
    constructor() {
        
    }

    function getLsdRate(address _lsdToken) view external returns(uint256){
        return rates[_lsdToken];
    }
    function setLsdRate(address _lsdToken,uint256 _rate) external nonReentrant {
        //todo controller
        uint256 rate = rates[_lsdToken] ;
        require(_rate >= 1e18,"wrong _rate" );
        require(_rate > rate,"wrong _rate" );
        rates[_lsdToken] = _rate;
        emit LsdRateSeted(_lsdToken,_rate);
    }

    
}
