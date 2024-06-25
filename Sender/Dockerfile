# Use a lightweight Linux image
FROM alpine

# Install curl and jq to send HTTP requests and handle JSON
RUN apk add --no-cache curl jq

# Copy the script that sends the Java code and input data
COPY send_data.sh /send_data.sh

# Make the script executable
RUN chmod +x /send_data.sh

# Run the script
CMD ["/send_data.sh"]

