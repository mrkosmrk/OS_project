#pragma once
#include "../lib/hw.h"

class MemoryAllocator {
public:
    static MemoryAllocator* __get_instance();                          // returns singleton instance of allocator
    void* __mem_alloc(size_t size);                                    // allocates block of size bytes
    int __mem_free(void* ptr);                                         // frees part of memory to which ptr points

    MemoryAllocator(const MemoryAllocator&) = delete;                  // singleton class
    MemoryAllocator& operator = (const MemoryAllocator&) = delete;

    static size_t __convert_to_blocks(size_t size);
private:
    struct Header{                                                     // header on the beginning of each free block
        size_t size;                                                   // size of block
        Header* next;                                                  // pointer to the next block
    };

    static void __add_occupied(Header* ptr);                                  // adds block to occupied list of blocks
    static bool __check_and_delete_occupied(Header* ptr);                     // checks if ptr is pointer to occupied block

    static MemoryAllocator* allocator;                                 // instance of allocator
    static Header* free, *occ;                                         // pointer to beginning of free blocks list


};
