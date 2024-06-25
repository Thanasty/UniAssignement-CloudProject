#!/bin/sh

# Java code
java_code=$(cat <<'EOF'

import java.util.Random;

public class FibonacciSequence {

    // Method to generate a random number between 1 and 30
    public static int generateRandomNumber() {
        Random random = new Random();
        return random.nextInt(30) + 1; // Generates a number between 1 and 30
    }

    // Method to calculate Fibonacci sequence
    public static int[] calculateFibonacci(int n) {
        int[] fibonacciSequence = new int[n];
        if (n >= 1) {
            fibonacciSequence[0] = 0;
        }
        if (n >= 2) {
            fibonacciSequence[1] = 1;
        }
        for (int i = 2; i < n; i++) {
            fibonacciSequence[i] = fibonacciSequence[i - 1] + fibonacciSequence[i - 2];
        }
        return fibonacciSequence;
    }

    // Main method
    public static void main(String[] args) {
        int randomNumber = generateRandomNumber();
        System.out.println("Random number selected: " + randomNumber);

        int[] fibonacciSequence = calculateFibonacci(randomNumber);
        System.out.print("Fibonacci sequence: ");
        for (int number : fibonacciSequence) {
            System.out.print(number + " ");
        }
    }
}

EOF
)

# Input data
input_data="10\n20\n30\ndone\n"

# JSON payload
json_payload=$(jq -n --arg code "$java_code" --arg input "$input_data" '{code: $code, input: $input}')
echo "Sending JSON payload: $json_payload"

# Send the Java code and input data to the compiler container
curl -X POST -H "Content-Type: application/json" -d "$json_payload" http://compiler-container:8080/compile

