/*
 * SPDX-License-Identifier: MIT
 *
 * Copyright (c) 2024 Johannes Arnold
 *
 * This code was adapted from Sergey Lyubka's MDK:
 * https://github.com/cpq/mdk/tree/e2c1d4e4bd9b152dfa32b48a7c0ae5f5a8b8276d
 *
 * Below is the original copyright:
 * Copyright (c) 2021 Cesanta
 * All rights reserved
 */

#include "c3dk.h"

extern int main(void);
extern char _sbss, _ebss, _end, _eram;

static char *s_heap_start, *s_heap_end, *s_brk;

void *sbrk(int diff) {
  char *old = s_brk;
  if (&s_brk[diff] > s_heap_end)
    return NULL;
  s_brk += diff;
  return old;
}

void _reset(void) {
  s_heap_start = s_brk = &_end, s_heap_end = &_eram;
  for (char *p = &_sbss; p < &_ebss;)
    *p++ = '\0';
  soc_init();
  main();
  for (;;)
    (void)0;
}
