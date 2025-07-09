#!/bin/bash

# Create fonts directory if it doesn't exist
mkdir -p Fonts

# Download Poppins fonts
curl -L "https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Regular.ttf" -o "Fonts/Poppins-Regular.ttf"
curl -L "https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Medium.ttf" -o "Fonts/Poppins-Medium.ttf"
curl -L "https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-SemiBold.ttf" -o "Fonts/Poppins-SemiBold.ttf"
curl -L "https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Bold.ttf" -o "Fonts/Poppins-Bold.ttf"

# Make the script executable
chmod +x download_fonts.sh 