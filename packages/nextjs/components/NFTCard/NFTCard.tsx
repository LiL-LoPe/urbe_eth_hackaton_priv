import React from "react";
import Image from "next/image";

const NFTCard = ({ imageUrl, onClickMint }) => {
	return (
		<div className="nft-card">
			<a onClick={onClickMint}>
				<Image src={imageUrl} alt="NFT Image" width={200} height={200} />
			</a>
			<button onClick={onClickMint}>Mint NFT</button>
		</div>
	);
};

export default NFTCard;
