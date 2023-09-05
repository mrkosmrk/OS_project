#include "../h/_buffer.hpp"
#include "../lib/hw.h"
#include "../h/syscall_c.hpp"

buffer_t _buffer::putcBuffer = nullptr;
buffer_t _buffer::getcBuffer = nullptr;

buffer_t _buffer::buffer_create(unsigned size)
{
    buffer_t buffer = (buffer_t)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(_buffer)));
    if (!buffer)
        return nullptr;

    buffer->head = buffer->tail = buffer->occupied =  0;
    buffer->size = size;
    buffer->buffer = (char*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(size));
    if (!buffer->buffer)
    {
        MemoryAllocator::__get_instance()->__mem_free(buffer);
        return nullptr;
    }

    buffer->producer = _sem::semaphore_create(size);
    if (!buffer->producer)
    {
        MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
        MemoryAllocator::__get_instance()->__mem_free(buffer);
        return nullptr;
    }
    buffer->consumer = _sem::semaphore_create(0);
    if(!buffer->consumer)
    {
        MemoryAllocator::__get_instance()->__mem_free(buffer->producer);
        MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
        MemoryAllocator::__get_instance()->__mem_free(buffer);
        return nullptr;
    }
    buffer->mutex = _sem::semaphore_create(1);
    if (!buffer->mutex)
    {
        MemoryAllocator::__get_instance()->__mem_free(buffer->producer);
        MemoryAllocator::__get_instance()->__mem_free(buffer->consumer);
        MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
        MemoryAllocator::__get_instance()->__mem_free(buffer);
        return nullptr;
    }

    return buffer;
}

void _buffer::produce(buffer_t buffer, char c, bool isSysCall)
{
    int res;
    if (!isSysCall)
        res = sem_wait(buffer->producer);
    else
        res = _sem::wait(buffer->producer);
    if (res < 0)
        _thread::thread_exit();
    if (!isSysCall)
        sem_wait(buffer->mutex);
    else
        _sem::wait(buffer->mutex);
    buffer->buffer[buffer->head] = c;
    buffer->head = (buffer->head + 1) % buffer->size;
    ++buffer->occupied;
    if (!isSysCall)
        sem_signal(buffer->mutex);
    else
        _sem::signal(buffer->mutex);
    if (!isSysCall)
        sem_signal(buffer->consumer);
    else
        _sem::signal(buffer->consumer);
}

char _buffer::consume(buffer_t buffer, bool isSysCall)
{
    if (!isSysCall)
        sem_wait(buffer->consumer);
    else
        _sem::wait(buffer->consumer);
    if (!isSysCall)
        sem_wait(buffer->mutex);
    else
        _sem::wait(buffer->mutex);
    if (buffer == _buffer::getcBuffer)
    {
        if (_buffer::isFull(_buffer::getcBuffer))
            plic_complete(CONSOLE_IRQ);
    }
    char c = buffer->buffer[buffer->tail];
    buffer->tail = (buffer->tail + 1) % buffer->size;
    --buffer->occupied;
    if (!isSysCall)
        sem_signal(buffer->mutex);
    else
        _sem::signal(buffer->mutex);
    if (!isSysCall)
        sem_signal(buffer->producer);
    else
        _sem::signal(buffer->producer);

    return c;
}

bool _buffer::isFull(buffer_t buffer)
{
    return buffer->occupied == buffer->size;
}

bool _buffer::isEmpty(buffer_t buffer)
{
    return buffer->occupied == 0;
}

void _buffer::buffer_free(buffer_t buffer)
{
    _sem::close(buffer->producer, _thread::SEMCLOSED);
    _sem::close(buffer->consumer, _thread::SEMCLOSED);
    MemoryAllocator::__get_instance()->__mem_free(buffer->buffer);
    MemoryAllocator::__get_instance()->__mem_free(buffer);
}


