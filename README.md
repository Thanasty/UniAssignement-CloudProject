# Java Compilation with Docker

## Περιγραφή
Στην εργασία αυτή, έχουν υλοποιηθεί δύο Docker images όπου το ένα είναι υπεύθυνο να στείλει ένα πηγαίο κώδικα Java στο άλλο, το οποίο τον κάνει compile, τον τρέχει και εμφανίζει τα αποτελέσματα. Στο συγκεκριμένο παράδειγμα, ο κώδικας υπολογίζει μια ακολουθία Fibonacci ενός τυχαίου αριθμού μεταξύ 1 και 30.

## Οδηγίες Εγκατάστασης

1. **Δημιουργία των Docker Images**
   ```bash 
   docker build -t sender-image ./Sender
   ```
   ```bash 
   docker build -t compiler-image ./Compiler
   ```
2. **Εκτέλεση του Compiler Container**
   ```bash
   docker run -d --name compiler-container -p 8080:8080 compiler-image
   ```
3. **Έλεγχος των Logs για να βεβαιωθείτε ότι ο server τρέχει**
   ```bash
   docker logs compiler-container
   ```
4. **Εκτέλεση του Sender Container**
   ```bash
   docker run --rm --link compiler-container sender-image
   ```
## Τροποποίηση του Πηγαίου Κώδικα
Αν χρειαστεί να αλλάξουμε τον πηγαίο κώδικα που θα γίνεται compile, τροποποιούμε το αρχείο send_data.sh και ξαναφτιάχνουμε τα Docker images.
   ```bash 
   docker build -t sender-image ./Sender
   ```
   ```bash 
   docker build -t compiler-image ./Compiler
   ```
