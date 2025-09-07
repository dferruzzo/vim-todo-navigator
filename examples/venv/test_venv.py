import numpy as np
import matplotlib.pyplot as plt

if __name__ == "__main__":
    # Generate sample data
    x = np.linspace(0, 10, 100)
    y1 = np.sin(x)
    y2 = np.cos(x)

    # TODO: Add a legend to the plot    
    
    # Create a figure and axis
    fig, ax = plt.subplots()

    # Plot the first line with a label
    line1, = ax.plot(x, y1, label='Sine Wave', color='blue')

    # Plot the second line with a label
    line2, = ax.plot(x, y2, label='Cosine Wave', color='orange')

    # Add title and labels
    ax.set_title('Sine and Cosine Waves')
    ax.set_xlabel('X-axis')
    ax.set_ylabel('Y-axis')

    # Add a legend to the plot
    ax.legend()

    # Show the plot
    plt.show()