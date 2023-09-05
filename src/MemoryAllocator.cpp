#include "../h/MemoryAllocator.hpp"

MemoryAllocator* MemoryAllocator::allocator = nullptr;
MemoryAllocator::Header* MemoryAllocator::free = nullptr;
MemoryAllocator::Header* MemoryAllocator::occ = nullptr;

MemoryAllocator* MemoryAllocator::__get_instance() {
    if (!allocator)                                                                                             // check if allocator is set
    {
        free = (Header*)((size_t)HEAP_START_ADDR + sizeof(MemoryAllocator));
        free->size = (size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - sizeof(Header) - sizeof(MemoryAllocator);
        free->next = nullptr;
        occ = nullptr;
        allocator = (MemoryAllocator*)HEAP_START_ADDR;
    }

    return allocator;
}

void* MemoryAllocator::__mem_alloc(size_t size) {
    if (size == 0)
        return nullptr;

    size = size * MEM_BLOCK_SIZE;                      // real number of bytes to allocate

    Header* curr = free;
    Header* prev = nullptr;
    while (curr)
    {
        if (curr->size >= size)                                         // check if current block has enough memory
        {
            if (curr->size - size < MEM_BLOCK_SIZE + sizeof(Header))                    // check if the rest of block is big enough to make new block
            {
                if (prev)
                    prev->next = curr->next;
                else
                    free = curr->next;
            }
            else
            {
                Header* newBlock = (Header*)(((size_t)curr) + size + sizeof(Header));
                newBlock->next = curr->next;
                newBlock->size = curr->size - size - sizeof(Header);
                if (prev)
                    prev->next = newBlock;
                else
                    free = newBlock;
                curr->size = size;
            }
            __add_occupied(curr);                                       // adds new block to occupied list

            return (void*)(((size_t)curr) + sizeof(Header));
        }
        prev = curr;
        curr = curr->next;
    }
    free = nullptr;
    return nullptr;
}

void MemoryAllocator::__add_occupied(Header* ptr) {
    ptr->next = occ;
    occ = ptr;
}

bool MemoryAllocator::__check_and_delete_occupied(Header* ptr) {
    if (!occ)
        return false;

    Header* curr = occ;
    Header* prev = nullptr;

    while (curr)
    {
        if (curr == ptr)
        {
            if (prev)
                prev->next = curr->next;
            else
                occ = curr->next;

            return true;
        }
        prev = curr;
        curr = curr->next;
    }

    return false;
}

int MemoryAllocator::__mem_free(void* ptr) {
    if (ptr == nullptr)
        return 0;

    Header* block = (Header*)(((size_t)ptr) - sizeof(Header));
    if (!__check_and_delete_occupied(block))
        return -1;                                                                              // invalid pointer

    if (!free)
    {
        free = block;
        free->next = nullptr;
        return 0;
    }

    if ((size_t)block < (size_t)free)
    {
        if (((size_t)block) + block->size + sizeof(Header) == (size_t)free)
        {
            block->size += sizeof(Header) + free->size;
            block->next = free->next;
            free = block;
        }
        else
        {
            block->next = free;
            free = block;
        }
        return 0;
    }

    Header* curr = free;

    while (curr)
    {
        if ((!curr->next) || (curr->next && (size_t)block < (size_t)curr->next))
        {
            if ((Header*)(((size_t)curr) + sizeof(Header) + curr->size) == block)                           // block can be united with previous block
            {
                curr->size += sizeof(Header) + block->size;
                block = curr;                                                                   // this is to make block->next = curr->next
            }
            else
            {
                block->next = curr->next;
                curr->next = block;
            }

            if (block->next && (Header*)(((size_t)block) + sizeof(Header) + block->size) == block->next)    // block can be united with next block
            {
                block->size += block->next->size + sizeof(Header);
                block->next = block->next->next;
            }

            return 0;
        }
        curr = curr->next;
    }

    return -2;
}

size_t MemoryAllocator::__convert_to_blocks(size_t size)
{
    return (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;
}
