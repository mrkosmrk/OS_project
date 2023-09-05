#pragma once
class _thread;
typedef _thread* thread_t;

class Scheduler {
public:
    static int put(thread_t);
    static thread_t get();

private:
    struct Node
    {
        thread_t thread;
        Node* next;
    };

    static Node* head, *tail;
};
