import {ethers} from 'ethers';
import borrow from '../../../sol/borrow.json'

const AVEE_PROXY_CONTRACT="0x13d1Ed8c24911d88e6155cE32A66908399C97924"
const ETH_PROXY_CONTRACT="0x26690F9f17FdC26D419371315bc17950a0FC90eD"
const USDC_PROXY_CONTRACT="0x8DF7d919Fe9e866259BB4D135922c5Bd96AF6A27"

const AVEE_TOKEN_CONTRACT="0xaF6385D67f47179dEF0B428Ec9a14D47628feC82"
const USDC_TOKEN_CONTRACT="0x316B3Cad43301a5A2F46198f44aEF44cbA306345"
const ETH_TOKEN_CONTRACT="0x75A61E17f0A354180817A6B45D4470B61F3FDfD6"

const BORROWTOKENCOTRACT="0xd5C1CBcD3d0442005535Bb9cf3C4Fa387dF39104"

export const getTokenPrice = async ()=>{
    try{
    if(typeof window.ethereum !== undefined){
    let provider =  new ethers.providers.Web3Provider(window.ethereum);
    let signer =  provider.getSigner();
    let balance = await signer.getBalance();
    let mainAccountBalance = (Number(balance) / 1e18).toFixed(3);
  
     return {provider , signer , borrow ,mainAccountBalance };
    }
    }catch(err){
        console.log("not connected");
    }
}

export const tokenProxy = async (tokenAddress)=>{
  const   {provider , signer , borrow ,mainAccountBalance }= await getTokenPrice(); 
  const contract_borrow =   new ethers.Contract(BORROWTOKENCOTRACT ,borrow , signer);
  const tx = await contract_borrow.getAllTokenPriceProxy(tokenAddress);
 let tokenPrice = Number(tx[0]);
 let tokenTimeStamp = Number(tx[1]);
  return {tokenPrice , tokenTimeStamp}
}

export const baseTokenPrice = async ()=>{
    const   {provider , signer , borrow ,mainAccountBalance }= await getTokenPrice(); 
    const contract_borrow =   new ethers.Contract(BORROWTOKENCOTRACT ,borrow , signer);
    const tx = await contract_borrow.getBaseContractProxyPrice();
   let basePrice = Number(tx[0]);
   let baseTimeStamp = Number(tx[1]);
    return {basePrice , baseTimeStamp}
}

export const borrowToken = async ()=>{
    const   {provider , signer , borrow ,mainAccountBalance }= await getTokenPrice(); 
    const contract_borrow =   new ethers.Contract(BORROWTOKENCOTRACT ,borrow , signer);
    const tx = await contract_borrow.getBaseContractProxyPrice();
   let basePrice = Number(tx[0]);
   let baseTimeStamp = Number(tx[1]);
    return {basePrice , baseTimeStamp}
}


