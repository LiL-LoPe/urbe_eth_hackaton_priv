"use client";

import { useState } from "react";
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

const Home: NextPage = () => {
	// Prende i dati dell-account
	const { address } = useAccount();

	const [showTextBox, setShowTextBox] = useState(false);
	const [value, setValue] = useState(0);

	const handleLinkClick = (link) => {
		switch (link) {
			case "link1":
				// Logica per gestire il clic sul link 1
				console.log("Link 1 clicked");
				break;
			case "link2":
				// Logica per gestire il clic sul link 2
				console.log("Link 2 clicked");
				break;
			case "link3":
				// Logica per gestire il clic sul link 3
				console.log("Link 3 clicked");
				if(!showTextBox)
					setShowTextBox(true); // Mostra il div con la textbox
				if(showTextBox)
					setShowTextBox(false);
				break;
			default:
				console.log("Unknown link clicked");
		}
	};

	const { writeAsync: mintSign } = useScaffoldContractWrite({
		contractName: "NuminousNecessities",
		functionName: "mintSign",
		args: [value],
	});
	// Stato per indicare se il minting è in corso
	const [isMinting, setIsMinting] = useState(false);
	// Funzione per gestire il minting dell'NFT
	const handleMintSign = async () => {
		if (value > 2) {
			// Visualizzare un messaggio di errore
			console.log("Error: you can only mint two.");
		}
		try {
			setIsMinting(true); // Imposta lo stato del minting su true per indicare che il minting è in corso
			await mintSign();
			// Una volta completato il minting, reimposta lo stato del minting su false
			setIsMinting(false);
		} catch (error) {
			console.error("Errore durante il minting:", error);
			setIsMinting(false); // Assicurati di reimpostare lo stato del minting su false in caso di errore
		}
	};

	const handleIncrement = () => {
		setValue((prevValue) => prevValue + 1);
	};

	const handleDecrement = () => {
		setValue((prevValue) => (prevValue > 0 ? prevValue - 1 : 0));
	};
	
	return (
		<>
		<div className="landscape-background relative flex justify-center items-center h-screen bg-cover bg-center" style={{ backgroundImage: `url('https://i.ibb.co/Hxh8JHs/bgdefinitivo.jpg')` }}>
			<div className="landscape-container flex flex-row h-full max-h-screen">
				{/* Prima parte */}
				<div className="w-1/3 h-full flex flex-col justify-center items-center relative">
					<a href="#" onClick={() => handleLinkClick("link1")}>
						<img src="https://i.ibb.co/6JNK7KF/center.png" alt="center" border="0" />
					</a>
				</div>

				{/* Seconda parte */}
				<div className="w-1/3 h-full flex flex-col justify-center items-center relative">
					<a href="#" onClick={() => handleLinkClick("link2")}>
						<img src="https://i.ibb.co/yNJNgTv/center.png" alt="magasmall" border="0" />
					</a>
				</div>

				{/* Terza parte */}
				<div className="w-1/3 h-full flex flex-col justify-center items-center relative">
					<a href="#" onClick={() => handleLinkClick("link3")} className="gif-image">
						<img src="https://i.ibb.co/m588y9s/mage2.png" alt="magasmall" border="0" className="img" />
						<img src="https://i.ibb.co/1LpJKp8/magegif.gif" alt="Animated GIF" className="gif" />
					</a>
					{showTextBox && (
						<div className="absolute top-0 left-1/2 transform -translate-x-1/2 mt-16 p-4">
							<input
								type="number"
								value={value}
								onChange={(e) => setValue(parseInt(e.target.value))}
								className="w-20 px-2 py-1 mr-2 border border-gray-300 rounded"
							/>
							<button onClick={handleDecrement} className="px-3 py-1 mr-2 bg-gray-200 rounded">-</button>
							<button onClick={handleIncrement} className="px-3 py-1 mr-2 bg-gray-200 rounded">+</button>
							<button onClick={handleMintSign} className="px-3 py-1 bg-gray-200 rounded">Mint Sign</button>
						</div>
					)}
				</div>
			</div>
		</div>
		</>
		);
	};
	
	export default Home;
	