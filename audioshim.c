#include <stdio.h>
#include <stdlib.h>

void real_hook(void* node) __attribute__((visibility("default")));
void real_hook(void* node) {
    fprintf(stderr, "_M_hook called\n");
}

void real_unhook(void) __attribute__((visibility("default")));
void real_unhook(void) {
    fprintf(stderr, "_M_unhook called\n");
}

__asm__(".symver real_hook,_ZNSt8__detail15_List_node_base7_M_hookEPS0_@@GLIBCXX_3.4.15");
__asm__(".symver real_unhook,_ZNSt8__detail15_List_node_base9_M_unhookEv@@GLIBCXX_3.4.15");

void __cxa_pure_virtual(void) __attribute__((visibility("default")));
void __cxa_pure_virtual(void) {
    fprintf(stderr, "Pure virtual function called. Exiting?\n");
    abort();
}
