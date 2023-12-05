/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: at0m <at0m@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/05 13:08:37 by at0m              #+#    #+#             */
/*   Updated: 2023/12/05 13:15:29 by at0m             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <cstdio>
#include "cuda.h"
#include  <math.h>
#include "lol.h"
#include <iostream>
#include <cuda_runtime.h>
#include <cuda_gl_interop.h>
#include <GL/glut.h>

__global__
void GPUFunction_zeta(double s_r, double s_i, double *real, double *imag)
{
	int	n;
	double a;
	double b;

	n = 1;
	printf("zeta arg : %f + i * %f\n", s_r, s_i);
	while (n < 5000)
	{
		a = cos(s_i * log(n));
		b = sin(s_i * log(n));
		*real += a / ((pow(a, 2) + pow(b, 2)) * pow(n, s_r));
		*imag += -b / ((pow(a, 2) + pow(b, 2)) * pow(n, s_r));
		n++;
	}
}

__global__
void	riemann(t_var *f, t_riemann *r, double t, double sigma)
{
	double			tmp;
	unsigned int	n;
	double			max;
	int				ntz = 0;

	n = 0;
	max = 7500;
	GPUFunction_zeta<<<1, 12>>>(sigma, t, &(f->c_r), &(f->c_i));
	if (approx(sigma) && approx2(f->c_i) && approx2(f->c_r))
	{
		ntz = 1;
		printf("NTZ\n");
	}
	f->c_r = (r->w1 * sign(f->c_r) * log(ft_dabs(f->c_r)) + r->w2);
	f->c_i = (r->w3 * sign(f->c_i) * log(ft_dabs(f->c_i)) + r->w4);
	while (module(f->z_r, f->z_i) <= 2 && n < max)
	{
		tmp = f->z_r;
		f->z_r = (f->z_r * f->z_r) - f->z_i * f->z_i + f->c_r;
		f->z_i = 2 * tmp * f->z_i + f->c_i;
		n++;
	}
	if (n == max)
		return ;
}

__global__
void GPUFunction()
{
  printf("hello from the Gpu.\n");
}

int main()
{
	//unsigned int	p;
	t_var			    *f_mandelbrodt;
	t_riemann		  *f_r;
	


  f_r = (t_riemann *)malloc(sizeof(t_riemann));
  f_r->smin = -14;
  f_r->smax = 8;
  f_r->tmin = -16;
  f_r->tmax = 16;
  if (f_r->smax - f_r->smin != 0)
  {
    f_r->h = floor(900 *  (f_r->tmax - f_r->tmin) / (f_r->smax - f_r->smin));
    f_r->w1 = 2.47 / (f_r->smax - f_r->smin);
    f_r->w2 = (0.47 * f_r->smin + 2 * f_r->smax) / (f_r->smax - f_r->smin);
    f_r->w3 = 2.24 / (f_r->tmax - f_r->tmin);
    f_r->w4 = 1.12 * (f_r->tmin + f_r->tmax) / (f_r->tmin - f_r->tmax);
  }
			//double sigma = f_r->smin + x * (f_r->smax - f_r->smin) / (WIDTH);
			//p = riemann(ft_init_var_mandelbrodt(), f_r, t, sigma);
			//p = julia(x, y, f_julia, 1);

  GPUFunction<<<1, 1>>>();

  for (int y = 0; y < 900; y++)
	{
		double t = f_r->tmin + y * (f_r->tmax - f_r->tmin) / (900);
		for (int x = 0; x < 900; x++)
		{
			double sigma = f_r->smin + x * (f_r->smax - f_r->smin) / (900);
		
			riemann<<<1, 100>>>(f_mandelbrodt, f_r, t, sigma);
			std::cout << "x : " << x << " y : " << y << std::endl;
		}
	}

  cudaDeviceSynchronize();

  return EXIT_SUCCESS;
}