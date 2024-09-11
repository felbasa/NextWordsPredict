# Web Application for Visualizing Survey Data

## Overview

This Shiny web application is designed to collect and visualize responses from a Google Form in real-time. The app reads the survey data from a Google Sheet, processes the results, and displays interactive bar plots (histograms) for each survey question. It provides an intuitive interface for exploring the distribution of responses to different questions.

### Features
- **Real-time Data Collection**: The application connects to a Google Sheet, which collects responses from a Google Form, ensuring that all visualizations are based on the most up-to-date data.
- **Interactive Visualizations**: The app uses `ggplot2` to generate dynamic bar plots (similar to histograms) for each question, allowing users to visualize the distribution of responses.
- **Seamless Deployment**: The application is deployed on [shinyapps.io](https://www.shinyapps.io), ensuring accessibility from any web browser.

## Application Functionality

1. **Data Source**: 
   - The app fetches survey responses from a Google Sheet that is connected to a Google Form.
   - Data is automatically refreshed to include new responses as they are submitted to the Google Form.

2. **Bar Plot Generation**: 
   - The app generates bar plots for each question, visualizing the frequency of responses.
   - Color-blind-friendly colors are used in the plots to ensure accessibility.
   - Each plot includes titles, axis labels, and count information to make the data easy to understand.

3. **User Interface**:
   - Users can view the plots for different questions side by side.
   - The interface is simple and clean, making it easy to navigate through different survey questions.

## Getting Started

### Prerequisites
- **R and Shiny**: The application is built using the R Shiny framework, so you will need to have R installed on your machine to run it locally.
- **Google Sheets API**: Make sure you have access to the Google Sheets API with the proper authentication (service account or OAuth 2.0) to retrieve form responses.

### Running Locally

1. Clone this repository:
   ```bash
   git clone https://github.com/your-repo-name/your-app-name.git
