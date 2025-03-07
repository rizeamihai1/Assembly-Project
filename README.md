Assembly Project: Conway’s Game of Life & Encryption/Decryption
This project is implemented entirely in Assembly and consists of three main tasks:

Overview
The project is based on a variant of Conway’s Game of Life. The evolved state of the cellular grid is also used to generate a key for a simple symmetric encryption/decryption mechanism. The three tasks are organized as follows:

Task 0x00: Simulate the Game of Life.
Task 0x01: Encrypt or decrypt a message using the evolved grid as a key.
Task 0x02: Similar to Task 0x00, but input is read from a file and output is written to a file.
Task Details
Task 0x00 – The Game
Objective:
Simulate Conway’s Game of Life for a given number of evolution steps.
Input:
Matrix dimensions (number of rows m and columns n).
Number of live cells (p) and their positions in the matrix.
An integer k representing the number of evolution iterations.
Process:
The program reads the initial configuration, performs k evolution steps (applying the rules of Conway’s Game of Life), and prints the final state of the matrix.
Output:
The final configuration of the matrix after k evolutions is printed to standard output.
Task 0x01 – Encryption/Decryption
Objective:
Use the evolved grid to generate a key for XOR-based encryption or decryption.
Input:
Matrix dimensions, number of live cells and their positions, and the integer k (as in Task 0x00).
An additional integer flag (o): 0 for encryption, 1 for decryption.
A message:
Plaintext (without spaces) for encryption.
A hexadecimal string (starting with 0x) for decryption.
Process:
The program generates a key from the k-evolved configuration (by concatenating the extended matrix rows into a one-dimensional bit array).
The message is then XOR-ed with this key:
If the message is longer than the key, the key is repeated.
For decryption, the same XOR process is applied to recover the original message.
Output:
Encrypted messages are displayed in hexadecimal format.
Decrypted messages are displayed as plain text.
Task 0x02 – File-Based I/O
Objective:
Implement the Game of Life simulation (as in Task 0x00) using file input and output.
Input/Output:
The input is read from a file named in.txt.
The final configuration (after k evolutions) is written to a file named out.txt.
Process:
The core logic remains identical to Task 0x00, with file I/O handled via C functions.
