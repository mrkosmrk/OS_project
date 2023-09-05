#pragma once
#include "MemoryAllocator.hpp"


template<typename T>
class List {
public:
    List();

    static List* list_create();

    int put(T* elem);
    T* get();
    T* peek();
    bool empty();
    void setBegin();
    bool isEnd();
    void nextElem();
    bool compare(T* elem);
    T* getCurrent();
    int removeElem(T* elem);
    int putInOrder(bool (*cmp)(T*, T*), T* elem);

private:
    struct Node {
        T* elem;
        Node* next;
    };

    Node* head, *tail;
    Node* tmp;
};

template<typename T>
T *List<T>::getCurrent() {
    if (!tmp)
        return nullptr;
    return tmp->elem;
}

template<typename T>
T *List<T>::peek() {
    if (!head)
        return nullptr;
    return head->elem;
}

template<typename T>
int List<T>::putInOrder(bool (*cmp)(T *, T *), T *elem) {
    Node* curr = head;
    Node* prev = nullptr;
    Node* newNode = (Node*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(Node)));
    if (!newNode)
        return -1;
    newNode->elem = elem;
    newNode->next = nullptr;

    while (curr)
    {
        if (!cmp(curr->elem, elem))
        {
            newNode->next = curr;
            if (prev)
                prev->next = newNode;
            else
                head = newNode;
            return 0;
        }
        prev = curr;
        curr = curr->next;
    }
    if (tail)
        tail->next = newNode;
    tail = newNode;
    if (!head)
        head = newNode;

    return 0;
}

template<typename T>
int List<T>::removeElem(T *elem) {
    Node* curr = head;
    Node* prev = nullptr;

    while (curr)
    {
        if (curr->elem == elem)
        {
            Node* tmp = curr;
            if (prev)
                prev->next = curr->next;
            else
                head = curr->next;
            if (!head)
                tail = nullptr;
            int res = MemoryAllocator::__get_instance()->__mem_free(tmp);

            return res;
        }
        prev = curr;
        curr = curr->next;
    }
    return -3;
}

template<typename T>
bool List<T>::compare(T *elem) {
    if (!tmp)
        return false;
    return tmp->elem == elem;
}

template<typename T>
void List<T>::nextElem() {
    if (!tmp)
        return;
    tmp = tmp->next;
}

template<typename T>
bool List<T>::isEnd() {
    if (tmp)
        return false;
    return true;
}

template<typename T>
void List<T>::setBegin() {
    tmp = head;
}

template<typename T>
bool List<T>::empty() {
    return head == nullptr;
}

template<typename T>
List<T> *List<T>::list_create() {
    List<T>* list = (List<T>*)MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(List<T>)));
    if (!list)
        return nullptr;

    list->head = nullptr;
    list->tail = nullptr;
    list->tmp = nullptr;

    return list;
}

template<typename T>
T* List<T>::get() {
    if (!head)
        return nullptr;

    T* elem = head->elem;

    Node* oldHead = head;
    head = head->next;
    if (!head)
        tail = nullptr;

    int res = MemoryAllocator::__get_instance()->__mem_free(oldHead);
    if (res < 0)
        return nullptr; // ili nesto drugo

    return elem;
}

template<typename T>
int List<T>::put(T* elem) {
    Node* newNode = (Node*)(MemoryAllocator::__get_instance()->__mem_alloc(MemoryAllocator::__convert_to_blocks(sizeof(Node))));
    if (!newNode)
        return -1;

    newNode->elem = elem;
    newNode->next = nullptr;

    if (tail)
        tail->next = newNode;
    else
        head = newNode;
    tail = newNode;

    return 0;
}

template<typename T>
List<T>::List() {
    head = tail = nullptr;
}
