//
// Created by zika on 2/26/22.
//
#pragma once

#include "printing.hpp"

class _sem;

class Buffer {
private:
    typedef _sem* sem_t;
    int cap;
    int *buffer;
    int head, tail;

    sem_t spaceAvailable;
    sem_t itemAvailable;
    sem_t mutexHead;
    sem_t mutexTail;

public:
    Buffer(int _cap);
    ~Buffer();

    void put(int val);
    int get();

    int getCnt();

};



