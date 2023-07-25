// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILsdRateOracle {
    
    event LsdRateSeted(address indexed _lsdToken, uint256 _amount);

    function getLsdRate(address _lsdToken) view external returns(uint256);

    function setLsdRate(address _lsdToken,uint256 _rate) external  ;

}
