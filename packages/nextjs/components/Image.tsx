// Image component
import React from 'react';

class Image extends React.Component {
  handleClick = () => {
    // Your function to be activated when the button is clicked
    // For example, you can log something to the console
    console.log('Button clicked!');
  }

  render() {
    const { imagePath } = this.props; // Get the image path from props
    return (
      <button className="image-button" onClick={this.handleClick}>
        <img src={imagePath} alt="Description of the image" className="image" />
      </button>
    );
  }
}

export default Image;
