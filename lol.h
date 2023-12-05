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
