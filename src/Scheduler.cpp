#include "../h/Scheduler.hpp"
#include "../h/_thread.hpp"
#include "../h/MemoryAllocator.hpp"

Scheduler::Node* Scheduler::head = nullptr;
Scheduler::Node* Scheduler::tail = nullptr;

int Scheduler::put(thread_t thread)
{
    Node* newThread = (Node*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(Node)));

    if (!newThread)
        return -1;

    newThread->thread = thread;
    newThread->next = nullptr;

    thread->currentState = _thread::READY;

    if (tail)
        tail->next = newThread;
    else
        head = newThread;
    tail = newThread;

    return 0;
}

thread_t Scheduler::get()
{
    if (!head)
        return nullptr;

    Node* node = head;
    thread_t thread = head->thread;

    head = head->next;
    if (tail == node)
        tail = nullptr;

    MemoryAllocator::__get_instance()->__mem_free(node);

    return thread;
}