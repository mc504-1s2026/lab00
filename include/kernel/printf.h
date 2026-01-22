#ifndef __PRINTF_H__
#define __PRINTF_H__

void print(const char *str);
void snprint_int(char *str, size_t size, int number, int base);

void printk(const char *fmt, ...);

#endif
