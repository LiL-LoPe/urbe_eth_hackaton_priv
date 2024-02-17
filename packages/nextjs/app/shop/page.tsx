"use client";

import "./shop.css";
import { useState, useEffect } from "react";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import Image from "next/image";
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
	
	const [isMintSign, setIsMintSign] = useState(false);
	// Effetto collaterale per avviare la funzione di lettura del contratto
	useEffect(() => {
		// Funzione di lettura del contratto
		const fetchData = async () => {
			try {
				const { data } = await useScaffoldContractRead({
					contractName: "NuminousNecessities",
					functionName: "isMintSign",
				});
				console.log("Risultato della chiamata al contratto:", data);
				setIsMintSign(data);
			} catch (error) {
				console.error("Errore durante la lettura del contratto:", error);
			}
		};

		console.log("Avvio della chiamata al contratto...");
		fetchData(); // Chiamata alla funzione di lettura del contratto al montaggio del componente
	}, []);

	// Aggiungiamo un console.log per verificare il valore di isMintSign
	console.log("Valore di isMintSign:", isMintSign);

	return (
		<>
		<div className="landscape-background relative flex flex-col justify-center items-center h-screen bg-cover bg-center" style={{ backgroundImage: `url('https://i.ibb.co/Hxh8JHs/bgdefinitivo.jpg')` }}>
			<div className="shop-div shop-tee">
				<div className="clothing-item">
					<img src="/tee1.png" alt="Merch 1" />
					<button className="buy-button">Acquista</button>
				</div>
				<div className="clothing-item">
					<img src="/tee2.png" alt="Merch 2" />
					<button className="buy-button">Acquista</button>
				</div>
				<div className="clothing-item">
					<img src="/tee3.png" alt="Merch 3" />
					<button className="buy-button">Acquista</button>
				</div>
			</div>
			{isMintSign ? (
			<div className="shop-div shop-hoodies">
				<div className="clothing-item">
					<img src="/hoodie1.png" alt="Merch 1" />
					<button className="buy-button">Acquista</button>
				</div>
				<div className="clothing-item">
					<img src="/hoodie2.png" alt="Merch 2" />
					<button className="buy-button">Acquista</button>
				</div>
				<div className="clothing-item">
					<img src="/hoodie1.png" alt="Merch 3" />
					<button className="buy-button">Acquista</button>
				</div>
			</div>
			) : null}
		</div>
		</>
		);
	};
	
	export default Shop;
	