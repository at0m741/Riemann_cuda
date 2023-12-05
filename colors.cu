
#include "lol.h"


__host__ __device__
double	ft_dabs(double n)
{
	if (n < 0)
		return (-n);
	return (n);
}
__host__ __device__
int	sign(double n)
{
	if (n < 0)
		return (-1);
	return (1);
}
__host__ __device__
double		approx(double n)
{
	return (n > 0.495 && n < 0.505);
}
__host__ __device__
double		approx2(double n)
{
	return (n > -0.5 && n < 0.5);
}
__host__ __device__
double	module(double a, double b)
{
	return (sqrt((a * a) + (b * b)));
}