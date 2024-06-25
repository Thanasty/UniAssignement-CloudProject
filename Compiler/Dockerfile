# Use the official OpenJDK image
FROM openjdk:11

# Install necessary tools
RUN apt-get update && apt-get install -y curl jq python3

# Create a directory for the project
RUN mkdir /usr/src/app

# Set the working directory
WORKDIR /usr/src/app

# Copy the script that handles the compilation and execution
COPY compile_and_run.sh /usr/src/app/compile_and_run.sh
COPY http_server.py /usr/src/app/http_server.py

# Make the script executable
RUN chmod +x /usr/src/app/compile_and_run.sh

# Expose port 8080
EXPOSE 8080

# Run the script
CMD ["/usr/src/app/compile_and_run.sh"]

