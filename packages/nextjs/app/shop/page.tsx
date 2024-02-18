"use client";

import "./shop.css";
import { useState, useEffect } from "react";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { Address, AddressInput, Balance } from "~~/components/scaffold-eth";
import { NFTCard } from "~~/components/NFTCard";
import {
	useAccountBalance,
	useDeployedContractInfo,
	useScaffoldContractRead,
	useScaffoldContractWrite,
} from "~~/hooks/scaffold-eth";

const Shop: NextPage = () => {
	// Prende i dati dell-account
	const { address } = useAccount();
	
	const { data: balanceOfNFT } = useScaffoldContractRead({
		contractName: "SignsNFT",
		functionName: "balanceOfNFT",
		args: [address],
	});

	console.log(balanceOfNFT);

	return (
		<>
		<div className="landscape-background relative flex flex-col justify-center items-center h-screen bg-cover bg-center" style={{ backgroundImage: `url('/bgshop.jpg')` }}>
			<div className="shop-div shop-tee">
				<div className="clothing-item">
					{balanceOfNFT > 0 && (<div className="discount-label">Discount</div>)}
					<img src="/tee1.png" alt="Merch 1" />
					<button className="buy-button">Acquista</button>
				</div>
				<div className="clothing-item">
					{balanceOfNFT > 0 && (<div className="discount-label">Discount</div>)}
					<img src="/tee2.png" alt="Merch 2" />
					<button className="buy-button">Acquista</button>
				</div>
				<div className="clothing-item">
					{balanceOfNFT > 0 && (<div className="discount-label">Discount</div>)}
					<img src="/tee3.png" alt="Merch 3" />
					<button className="buy-button">Acquista</button>
				</div>
			</div>
			{balanceOfNFT > 0 && (
			<div className="shop-div shop-hoodies">
				<div className="clothing-item">
					{balanceOfNFT > 0 && (<div className="discount-label">Discount</div>)}
					<img src="/hoodie1.png" alt="Merch 1" />
					<button className="buy-button">Acquista</button>
				</div>
				<div className="clothing-item">
					{balanceOfNFT > 0 && (<div className="discount-label">Discount</div>)}
					<img src="/hoodie2.png" alt="Merch 2" />
					<button className="buy-button">Acquista</button>
				</div>
				<div className="clothing-item">
					{balanceOfNFT > 0 && (<div className="discount-label">Discount</div>)}
					<img src="/hoodie1.png" alt="Merch 3" />
					<button className="buy-button">Acquista</button>
				</div>
			</div>
			)}
		</div>
		</>
		);
	};
	
	export default Shop;
	