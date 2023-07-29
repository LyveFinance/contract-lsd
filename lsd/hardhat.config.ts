import "dotenv/config";
import {HardhatUserConfig} from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-solhint";
import "@nomiclabs/hardhat-etherscan";
import "hardhat-contract-sizer";


const config: HardhatUserConfig = {
    defaultNetwork: "hardhat",
    solidity: {
        compilers: [
            {
                version: "0.8.13",
                settings: {
                    optimizer: {
                        enabled: true,
                        runs: 200,
                    },
                },
            },
            
        ],
        
    },
    networks: {
      linea_goerli: {
        url: `https://rpc.goerli.linea.build/`,
        accounts: [`${process.env.PRIVATE_KEY}`],
      },
      truffledashboard: {
        url: "http://localhost:24012/rpc"
      },
        arbitrum: {
            url: `https://arb-mainnet.g.alchemy.com/v2/${process.env.ALCHEMY_ARB_ONLINE}`,
            accounts: [`${process.env.PRIVATE_KEY}`],
        },
        arbitrumGoerli: {
            url: `https://arb-goerli.g.alchemy.com/v2/${process.env.ALCHEMY_ARB_GOERLI}`,
            accounts: [`${process.env.PRIVATE_KEY}`],
        },

        "base-goerli": {
            url: `https://goerli.base.org`,
            accounts: [`${process.env.PRIVATE_KEY}`],
        },
    },
    etherscan: {
        apiKey: {
            mainnet: `${process.env.API_KEY_ETH_ONLINE}`,
            goerli: `${process.env.API_KEY_ETH_GOERLI}`,
            arbitrumOne: `${process.env.API_KEY_ARB_ONLINE}`,
            arbitrumGoerli: `${process.env.API_KEY_ARB_GOERLI}`,
            // Basescan doesn't require an API key, however
            // Hardhat still expects an arbitrary string to be provided.
            "base-goerli": "PLACEHOLDER_STRING",
        },
        customChains: [
            {
                network: "base-goerli",
                chainId: 84531,
                urls: {
                    apiURL: "https://api-goerli.basescan.org/api",
                    browserURL: "https://goerli.basescan.org",
                },
            },
            {
                network: "arbitrumGoerli",
                chainId: 421613,
                urls: {
                    apiURL: "https://api-goerli.arbiscan.io/api",
                    browserURL: "https://goerli.arbiscan.io/",
                },
            },
            {
                network: "arbitrumOne",
                chainId: 42161,
                urls: {
                    apiURL: "https://api.arbiscan.io/api",
                    browserURL: "https://arbiscan.io/",
                },
            },
            
        ],
    },
    gasReporter: {},
    contractSizer: {
        runOnCompile: `${process.env.REPORT_SIZE}` == "true",
    },
};

export default config;
