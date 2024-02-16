// Row component
import React from 'react';
import Image from './Image'; // Import the Image component

class Row extends React.Component {
  render() {
    return (
      <div className="row">
        {/* Render three image components with different image paths */}
        <Image imagePath="./1.png" />
        <Image imagePath="./1.png" />
        <Image imagePath="./1.png" />
      </div>
    );
  }
}

export default Row;
