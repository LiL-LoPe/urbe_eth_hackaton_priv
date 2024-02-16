"use client";

import Link from "next/link";
import React from 'react';
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";
import { Address } from "~~/components/scaffold-eth";

const CollectionSliderRow = ({ images }) => {
	return (
	  <div className="collection-slider-row">
		<div className="collection-slider-row-slider vifnslb-container">
		  <div className="vifnslb-element" style={{ animationDuration: '30s', animationDirection: 'normal', animationDelay: '0s' }}>
			<div className="vifnslb-bar">
			  {images.map((image, index) => (
				<div key={index}><img src={image} alt={`Image ${index}`} /></div>
			  ))}
			</div>
			<div className="vifnslb-bar">
			  {images.map((image, index) => (
				<div key={index}><img src={image} alt={`Image ${index}`} /></div>
			  ))}
			</div>
		  </div>
		</div>
	  </div>
	);
  };

  class Collection extends React.Component {
	render() {
	  return (
		<div className="collection">
		  <div className="collection-bg" style={{ opacity: 2.13567 }}></div>
		  <div className="container" style={{ opacity: 1.13567 }}>
			<h2>Squishi<span className="fix"></span>verse Collection</h2>
			<p>Welcome to the Squishiverse, where cute, digital collectibles come to life. Inspired by iconic slime characters from Asian media, our Web3-native brand offers a wide range of heartwarming experiences, from collectibles and stories to merchandise and more. As a leader in the metaverse, we are dedicated to pushing the boundaries of Web3 and delivering innovative experiences.</p>
			<p>As a Squishie holder, you'll be part of a tight-knit community that values empowerment and strength. You'll have access to exclusive token-gated channels, events, individual IP opportunities, whitelists, NFTs, and other benefits throughout the Squishiverse ecosystem. Join us and discover all that the Squishiverse has to offer.</p>
		  </div>
		  <div className="collection-slider">
			<CollectionSliderRow images={[
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img'
			]} />
			<CollectionSliderRow images={[
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img'
			]} />
			<CollectionSliderRow images={[
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img',
			  '/img'
			]} />
		  </div>
		</div>
	  );
	}
  }

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  return (
    <>
    </>
  );
};

export default Collection;
