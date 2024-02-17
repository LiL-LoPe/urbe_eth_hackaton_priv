"use client";

import "./shop.css"; // Importa il file CSS
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

const Shop: NextPage = () => {
	return (
		<>
		<div className="landscape-background relative flex flex-col justify-center items-center h-screen bg-cover bg-center" style={{ backgroundImage: `url('https://i.ibb.co/Hxh8JHs/bgdefinitivo.jpg')` }}>
			<div className="shop-div shop-tee">
				<div className="clothing-item">
					<img src="/tee1.png" alt="Merch 1" />
					<button>Acquista</button>
				</div>
				<div className="clothing-item">
					<img src="/tee2.png" alt="Merch 2" />
					<button>Acquista</button>
				</div>
				<div className="clothing-item">
					<img src="/tee3.png" alt="Merch 3" />
					<button>Acquista</button>
				</div>
			</div>
			<div className="shop-div shop-hoodies">
				<div className="clothing-item">
					<img src="/hoodie1.png" alt="Merch 1" />
					<button>Acquista</button>
				</div>
				<div className="clothing-item">
					<img src="/hoodie2.png" alt="Merch 2" />
					<button>Acquista</button>
				</div>
				<div className="clothing-item">
					<img src="/hoodie1.png" alt="Merch 3" />
					<button>Acquista</button>
				</div>
			</div>
		</div>
		</>
		);
	};
	
	export default Shop;
	