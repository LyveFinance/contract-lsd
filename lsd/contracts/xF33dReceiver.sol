// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import {ILayerZeroEndpoint} from "./interfaces/ILayerZeroEndpoint.sol";
import {ILayerZeroReceiver} from "./interfaces/ILayerZeroReceiver.sol";
import {ILsdRateOracle} from "./interfaces/ILsdRateOracle.sol";
import {IxF33dReceiver} from "./interfaces/IxF33dReceiver.sol";



/**
 * @title xF33dReceiver
 * @dev This contract receives messages from LayerZero and updates the oracleData and lastUpdated variables.
 */
contract xF33dReceiver is ILayerZeroReceiver ,IxF33dReceiver{
    ILayerZeroEndpoint public lzEndpoint;
    address public srcAddress;

    bytes public oracleData;
    uint32 public lastUpdated;

    bool private initialized;

    address public lsdRateOracle;

    event FeedUpdated(uint32 lastUpdated);

    modifier isInitialized() {
        require(initialized != true, "already init");
        _;
    }

    function init(address _endpoint, address _srcAddress,address _lsdRateOracle) public isInitialized {
        lzEndpoint = ILayerZeroEndpoint(_endpoint);
        srcAddress = _srcAddress;
        initialized = true;
        lsdRateOracle = _lsdRateOracle;
    }

    function lzReceive(
        uint16,
        bytes memory _srcAddress,
        uint64,
        bytes calldata _payload
    ) public virtual override {
        require(msg.sender == address(lzEndpoint));
        address remoteSrc;
        assembly {
            remoteSrc := mload(add(_srcAddress, 20))
        }
        require(remoteSrc == srcAddress);

        oracleData = _payload;
        lastUpdated = uint32(block.timestamp);
        _setOracleRate();
        emit FeedUpdated(lastUpdated);
    }
    function _setOracleRate() internal   {
        lastUpdated = uint32(block.timestamp);
        (uint80 roundId, uint256 rate, uint256 startedAt, uint256 timestamp, uint80 answeredInRound) = abi.decode(
            oracleData,
            (uint80, uint256, uint256, uint256, uint80)
        );
        ILsdRateOracle(lsdRateOracle).setLsdRate(rate);
        emit FeedUpdated(lastUpdated);
    }
}
