/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   lol.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: at0m <at0m@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/05 14:59:04 by at0m              #+#    #+#             */
/*   Updated: 2023/12/05 14:59:42 by at0m             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LOL_H
# define LOL_H

# include "MacroLibX/includes/mlx.h"
# include <iostream>
# include <cuda_runtime.h>
# include <cuda_gl_interop.h>
# include <GL/glut.h>
# include <cstdio>
# include "cuda.h"
# include <math.h>

# define WIDTH 800
# define HEIGHT 600

struct s_frame
{
	void	*img;
	char	*addr;
	void	*mlx;
	void	*win;
	int		bit_ppx;
	int		line_size;
	int		endian;
};

typedef struct s_var
{
	double			z_r;
	double			z_i;
	double			c_r;
	double			c_i;
	double			a;
	void			*mlx;
	void			*win;	
	void			*img;
	uchar4			*pixels;
}	t_var;

typedef	struct s_riemann
{
	double tmin = -16;
	double tmax = 16;
	double smin = -14;
	double smax = 8;
	double h;
	double w1;
	double w2;
	double w3;
	double w4;
}	t_riemann;



__host__ __device__ double		ft_dabs(double n);
__host__ __device__ int			sign(double n);
__host__ __device__ double		approx(double n);
__host__ __device__ double		approx2(double n);
__host__ __device__ double		module(double a, double b);
__host__ __device__ double							lissage(int i, t_var *f, int m);
__host__ __device__ unsigned int					get_color(int i, t_var *f);

#endif