#pragma once
#include "_sem.hpp"

void console_handler();

class _buffer;
typedef _buffer* buffer_t;

class _buffer {
public:
    static buffer_t buffer_create(unsigned size);
    static void buffer_free(buffer_t buffer);

    static void produce(buffer_t buffer, char c, bool isSysCall);
    static char consume(buffer_t buffer, bool isSysCall);
    static bool isFull(buffer_t buffer);
    static bool isEmpty(buffer_t buffer);

    static buffer_t putcBuffer, getcBuffer;

private:
    unsigned head, tail, size, occupied;
    char* buffer;
    sem_t producer, consumer, mutex;

    friend int main();
    friend void console_handler();
};