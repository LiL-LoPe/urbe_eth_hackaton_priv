// Parent component for the container box
import React from 'react';
import Row from './Row'; // Import the Row component

class ContainerBox extends React.Component {
  render() {
    return (
      <div className="container-box">
        {/* Render three rows */}
        <Row />
        <Row />
        <Row />
      </div>
    );
  }
}

export default ContainerBox;
