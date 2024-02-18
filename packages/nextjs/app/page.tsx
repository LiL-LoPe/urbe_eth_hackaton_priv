"use client";

import "./home.css";
import { useState } from "react";
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

const Home: NextPage = () => {
	// Prende i dati dell-account
	const { address } = useAccount();

	const [showSignBox, setShowSignBox] = useState(false);
	const [valueSign, setValueSign] = useState(0);
	const [showMask, setShowMask] = useState(false);

	const handleCloseMask = () => {
		// Nascondi la maschera quando viene premuto il tasto "x"
		setShowMask(false);
	};

	const handleLinkClick = (link) => {
		switch (link) {
			case "link1":
				// Logica per gestire il clic sul link 1
				console.log("Link 1 clicked");
				break;
			case "link2":
				// Logica per gestire il clic sul link 2
				console.log("Link 2 clicked");
				setShowMask(true);
				break;
			case "link3":
				// Logica per gestire il clic sul link 3
				console.log("Link 3 clicked");
				if(!showSignBox)
					setShowSignBox(true); // Mostra il div con la textbox
				if(showSignBox)
					setShowSignBox(false);
				break;
			default:
				console.log("Unknown link clicked");
		}
	};

	const { writeAsync: mintSign } = useScaffoldContractWrite({
		contractName: "NuminousNecessities",
		functionName: "mintSign",
		args: [BigInt(valueSign)],
	});

	const { writeAsync: mintTarrots } = useScaffoldContractWrite({
		contractName: "TarrotsNFT",
		functionName: "mintTarrots",
		args: [BigInt(valueSign)],
	});

	// Stato per indicare se il minting è in corso
	const [isMinting, setIsMinting] = useState(false);
	// Funzione per gestire il minting dell'NFT
	const handleMintSign = async () => {
		if (valueSign > 2) {
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

	const handleMintTarrot = async () => {
		if (valueSign > 2) {
			// Visualizzare un messaggio di errore
			console.log("Error: you can only mint two.");
		}
		try {
			setIsMinting(true); // Imposta lo stato del minting su true per indicare che il minting è in corso
			await mintTarrots();
			// Una volta completato il minting, reimposta lo stato del minting su false
			setIsMinting(false);
		} catch (error) {
			console.error("Errore durante il minting:", error);
			setIsMinting(false); // Assicurati di reimpostare lo stato del minting su false in caso di errore
		}
	};

	const handleIncrement = () => {
		setValueSign((prevValueSign) => prevValueSign + 1);
	};

	const handleDecrement = () => {
		setValueSign((prevValueSign) => (prevValueSign > 0 ? prevValueSign - 1 : 0));
	};
	
	return (
		<>
		<div className="landscape-background relative flex justify-center items-center h-screen bg-cover bg-center" style={{ backgroundImage: `url('https://i.ibb.co/Hxh8JHs/bgdefinitivo.jpg')` }}>
			<div className="landscape-container flex flex-row h-full max-h-screen">
				{/* Prima parte */}
				<div className="w-1/3 h-full flex flex-col justify-center items-center relative">
					<a href="/shop" onClick={() => handleLinkClick("link1")}>
						<img src="https://i.ibb.co/6JNK7KF/center.png" alt="Shop" />
					</a>
				</div>

				{/* Seconda parte */}
				<div className="w-1/3 h-full flex flex-col justify-center items-center relative">
					<a href="#" onClick={() => handleLinkClick("link2")}>
						<img src="https://i.ibb.co/yNJNgTv/center.png" alt="center" className="fire" />
					</a>
					{/* Maschera */}
					{showMask && (
						<div className="mask fixed top-0 left-0 w-full h-full flex justify-center items-center bg-black bg-opacity-50">
							<div className="mask-content bg-white p-8 rounded-lg relative">
								<button className="close-button absolute top-2 right-2" onClick={handleCloseMask}>X</button>
								<h2 className="text-2xl mb-4">Alchemic Table</h2>
								{/* Contenuto della maschera */}
								<button className="button bg-blue-500 text-white px-4 py-2 rounded mr-2">Azione 1</button>
								<button className="button bg-blue-500 text-white px-4 py-2 rounded mr-2">Azione 2</button>
								<button onClick={handleMintTarrot} className="button bg-blue-500 text-white px-4 py-2 rounded">Mint Tarrots</button>
							</div>
						</div>
					)}
				</div>

				{/* Terza parte */}
				<div className="w-1/3 h-full flex flex-col justify-center items-center relative">
					<a href="#" onClick={() => handleLinkClick("link3")} className="gif-image">
						<img src="https://i.ibb.co/m588y9s/mage2.png" alt="MintSign" className="img" />
						<img src="https://i.ibb.co/1LpJKp8/magegif.gif" alt="MintSign" className="gif" />
					</a>
					{showSignBox && (
						<div className="absolute top-0 left-1/2 flex justify-center items-center transform -translate-x-1/2 mt-16 p-4">
							<button onClick={handleDecrement} className="button px-3 py-1 mr-2 bg-gray-200 rounded">-</button>
							<input
								type="number"
								value={valueSign}
								onChange={(e) => setValueSign(parseInt(e.target.value))}
								className="w-20 px-2 py-1 mr-2 border border-gray-300 rounded"
							/>
							<button onClick={handleIncrement} className="button px-3 py-1 mr-2 bg-gray-200 rounded">+</button>
							<button onClick={handleMintSign} className="button px-3 py-1 bg-gray-200 rounded">Mint Sign</button>
						</div>
					)}
				</div>
			</div>
		</div>
		</>
		);
	};
	
	export default Home;
	