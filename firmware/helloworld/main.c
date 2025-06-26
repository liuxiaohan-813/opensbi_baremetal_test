#include "sbi.h"
#include "tinyprintf/tinyprintf.h"

static void stdout_putc(void *unused,char ch)
{
	sbi_console_putchar(ch);
}

int main()
{
    init_printf(0, stdout_putc);

    sbi_console_putchar('\n');
    sbi_console_putchar('R');
    sbi_console_putchar('I');
    sbi_console_putchar('S');
    sbi_console_putchar('C');
    sbi_console_putchar('V');
    sbi_console_putchar('\n');

    tfp_printf("hello world\n");
    while(1) {}
}
