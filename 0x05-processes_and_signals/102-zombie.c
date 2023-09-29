#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/**
* infinite_while - Infinite loop
*
* Return: 0 succes
*/
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
* main - Create 5 zombie processes in the memory
*
* Return: 0 if the zombies creation didn't work
*         1 else
*/
int main(void)
{
	pid_t zombies;
	int i;

	for (i = 0; i < 5; i++)
	{
		zombies = fork();
		if (zombies == 0)
			return (0);
		printf("Zombie process created, PID: %d", zombies);
	}

	infinite_while();
	return (1);
}
