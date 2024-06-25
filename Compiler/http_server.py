from http.server import BaseHTTPRequestHandler, HTTPServer
import subprocess
import json
import os

class RequestHandler(BaseHTTPRequestHandler):
    def _set_response(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        print(f"Received POST request with data: {post_data}")
        data = json.loads(post_data)

        # Write the Java code to a file
        with open("FibonacciSequence.java", "w") as f:
            f.write(data['code'])

        # Write the input data to a temporary file
        with open("input.txt", "w") as f:
            f.write(data['input'])

        # Compile the Java code
        compile_process = subprocess.run(["javac", "FibonacciSequence.java"], capture_output=True, text=True)

        if compile_process.returncode != 0:
            response = {
                "status": "error",
                "message": "Compilation failed",
                "error": compile_process.stderr
            }
            print(f"Compilation failed: {compile_process.stderr}")
            self._set_response()
            self.wfile.write(json.dumps(response).encode('utf-8'))
            return

        # Run the Java program and pass the input file as stdin
        with open("input.txt", "r") as input_file:
            run_process = subprocess.run(
                ["java", "FibonacciSequence"], 
                stdin=input_file, 
                capture_output=True, 
                text=True
            )

        response = {
            "status": "success",
            "output": run_process.stdout,
            "error": run_process.stderr
        }
        print(f"Run output: {run_process.stdout}")
        print(f"Run error: {run_process.stderr}")

        self._set_response()
        self.wfile.write(json.dumps(response).encode('utf-8'))

        # Clean up
        os.remove("FibonacciSequence.java")
        os.remove("FibonacciSequence.class")
        os.remove("input.txt")

def run(server_class=HTTPServer, handler_class=RequestHandler, port=8080):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting httpd server on port {port}...')
    httpd.serve_forever()

if __name__ == '__main__':
    run()

