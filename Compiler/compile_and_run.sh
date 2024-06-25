#!/bin/sh

# Start a simple HTTP server to handle incoming requests
python3 /usr/src/app/http_server.py

while true; do
    # Wait for the request
    if [ -f request.json ]; then
        # Read the request
        code=$(jq -r '.code' request.json)
        input=$(jq -r '.input' request.json)

        # Save the Java code to a file
        echo "$code" > FibonacciSequence.java

        # Compile the Java code
        javac FibonacciSequence.java

        # Run the Java program with the provided input
        echo "$input" | java FibonacciSequence

        # Clean up
        rm -f request.json FibonacciSequence.java FibonacciSequence.class
    fi

    sleep 1
done

