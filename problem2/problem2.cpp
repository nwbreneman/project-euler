/*
Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
*/

#include <iostream>


int main() {
    int maxFib = 4000000;
    int n1 = 1;
    int n2 = 2;
    int tmp = 0;
    int sum = 0;

    while (n2 < maxFib) {
        tmp = n2 + n1;
        n1 = n2;
        n2 = tmp;

        if (n1 % 2 == 0) {
            sum += n1;
        }
    }

    std::cout << "Sum was " << sum << ".\n";

    return 0;
}