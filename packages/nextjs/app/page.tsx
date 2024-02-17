"use client";

import { useState } from "react";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { Address, AddressInput, Balance } from "~~/components/scaffold-eth";
import {
	useAccountBalance,
	useDeployedContractInfo,
	useScaffoldContractRead,
	useScaffoldContractWrite,
} from "~~/hooks/scaffold-eth";

const Home: NextPage = () => {
	// Prende i dati dell-account
	const { address } = useAccount();

	// Legge il contratto e la funzione greeting
	const { data: greeting } = useScaffoldContractRead({
		contractName: "YourContract",
		functionName: "greeting",
	});
	const { data: yourContract } = useDeployedContractInfo("YourContract");

	// Scrive il nuovo greeting usando la funzione setGreeting nel contratto
	const [newGreeting, setNewGreeting] = useState("");
	const { writeAsync: setGreeting } = useScaffoldContractWrite({
		contractName: "YourContract",
		functionName: "setGreeting",
		args: [newGreeting],
	});

	// Scrive un nuovo messaggio usando la funzione sendMessage nel contratto
	const [newReceiver, setNewReceiver] = useState("");
	const [newMessage, setNewMessage] = useState("");
	const { writeAsync: sendMessage } = useScaffoldContractWrite({
		contractName: "YourContract",
		functionName: "sendMessage",
		args: [newReceiver, newMessage],
	});

	return (
		<>
			<h1>Home</h1>
			<p>Welcome to the home page</p>
			{/* Elementi per mostrare l'indirizzo e il saldo dell'account */}
			<div className="flex items-center flex-col flex-grow pt-10">
				<div>
				<Address address={address} />
				<Balance address={address} />
				</div>
			</div>

			{/* Elementi per mostrare il greeting e per settare un nuovo greeting */}
			<div className="p-5 font-black text-xl">{greeting}</div>
			<div>
				<Address address={yourContract?.address} />
				<Balance address={yourContract?.address} />
			</div>

			<div className="p-5">
				<input
					value={newGreeting}
					placeholder="Type here"
					className="input"
					onChange={(e) => setNewGreeting(e.target.value)}
				/>
			</div>
			<div className="p-5">
				<button className="btn btn-primary" onClick={setGreeting}>
					Set Greeting
				</button>
			</div>

			{/* Elementi per inviare un messaggio */}
			<div className="p-5">
				<AddressInput
					value={newReceiver}
					placeholder="Recepient?"
					name={address}
					onChange={setNewReceiver}
				/>
			</div>
			<div className="p-5">
				<input
					value={newMessage}
					placeholder="Message"
					className="input"
					onChange={(e) => setNewMessage(e.target.value)}
				/>
			</div>
			<div className="p-5">
				<button className="btn btn-primary" onClick={sendMessage}>
					Send Message
				</button>
			</div>
		</>
	);
};

export default Home;
