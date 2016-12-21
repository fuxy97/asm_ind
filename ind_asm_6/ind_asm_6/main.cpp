#include <stdio.h>
#include <stdlib.h>
#include <locale.h>

//#define _CRT_SECURE_NO_WARNINGS
#define INT10_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c%c%c\n"
#define INT10_TO_BINARY(_int) (_int & 0x200 ? '1' : '0'), (_int & 0x100 ? '1' : '0'), (_int & 0x80 ? '1' : '0'), (_int & 0x40 ? '1' : '0'), (_int & 0x20 ? '1' : '0'), (_int & 0x10 ? '1' : '0'), (_int & 0x08 ? '1' : '0'), (_int & 0x04 ? '1' : '0'), (_int & 0x02 ? '1' : '0'), (_int & 0x01 ? '1' : '0')

extern "C"
{
	int bcdDec(int x0, int x1, int x2, int x3);
}

int main()
{
	setlocale(LC_ALL, "rus");
	int x0 = -1, x1 = -1, x2 = -1, x3 = -1;
	while (x0 > 1 || x0 < 0)
	{
		printf("¬ведите x0 (0 или 1): ");
		scanf("%d", &x0);
	}
	while (x1 > 1 || x1 < 0)
	{
		printf("¬ведите x1 (0 или 1): ");
		scanf("%d", &x1);
	}
	while (x2 > 1 || x2 < 0)
	{
		printf("¬ведите x2 (0 или 1): ");
		scanf("%d", &x2);
	}
	while (x3 > 1 || x3 < 0)
	{
		printf("¬ведите x3 (0 или 1): ");
		scanf("%d", &x3);
	}

	int res = bcdDec(x0, x1, x2, x3);
	printf("y: ");
	printf(INT10_TO_BINARY_PATTERN, INT10_TO_BINARY(res));

	system("pause");
	return 0;
}
