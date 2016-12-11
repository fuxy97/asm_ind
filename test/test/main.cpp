#include <iostream>


int main()
{
	int x = 0;
	int y = 5;
	
	if (x >= 0 && x <= 5 || y > 0 && y <= 5)
		std::cout << "x < y " << x << " < " << y;
	return 0;
}