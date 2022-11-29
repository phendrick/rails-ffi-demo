#include <stdio.h>
#include "hello.h"

void say_hello(char from_name[], hello_callback yield) {
    printf("[C] Hello, %s\n", from_name);

    char value[] = "C!";
    yield(value);
}
