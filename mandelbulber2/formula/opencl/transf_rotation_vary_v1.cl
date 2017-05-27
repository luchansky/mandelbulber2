/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * rotation variation v1. Rotation angles vary based on iteration parameters.
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
void TransfRotationVaryV1Iteration(float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 tempVC = (float4){fractal->transformCommon.rotation, 0.0f}; // constant to be varied

	if (aux->i >= fractal->transformCommon.startIterations250
			&& aux->i < fractal->transformCommon.stopIterations
			&& (fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250
					 != 0))
	{
		int iterationRange =
			fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250;
		int currentIteration = (aux->i - fractal->transformCommon.startIterations250);
		tempVC +=
			fractal->transformCommon.offset000 * native_divide((1.0f * currentIteration), iterationRange);
	}
	if (aux->i >= fractal->transformCommon.stopIterations)
	{
		tempVC = (tempVC + fractal->transformCommon.offset000);
	}

	tempVC *= native_divide(M_PI, 180.0f);

	*z = RotateAroundVectorByAngle4(*z, (float3){1.0f, 0.0f, 0.0f}, tempVC.x);
	*z = RotateAroundVectorByAngle4(*z, (float3){0.0f, 1.0f, 0.0f}, tempVC.y);
	*z = RotateAroundVectorByAngle4(*z, (float3){0.0f, 0.0f, 1.0f}, tempVC.z);
}
#else
void TransfRotationVaryV1Iteration(double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 tempVC = (double4){fractal->transformCommon.rotation, 0.0}; // constant to be varied

	if (aux->i >= fractal->transformCommon.startIterations250
			&& aux->i < fractal->transformCommon.stopIterations
			&& (fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250
					 != 0))
	{
		int iterationRange =
			fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250;
		int currentIteration = (aux->i - fractal->transformCommon.startIterations250);
		tempVC +=
			fractal->transformCommon.offset000 * native_divide((1.0 * currentIteration), iterationRange);
	}
	if (aux->i >= fractal->transformCommon.stopIterations)
	{
		tempVC = (tempVC + fractal->transformCommon.offset000);
	}

	tempVC *= M_PI / 180.0;

	*z = RotateAroundVectorByAngle4(*z, (double3) {1.0, 0.0, 0.0), tempVC.x};
	*z = RotateAroundVectorByAngle4(*z, (double3) {0.0, 1.0, 0.0), tempVC.y};
	*z = RotateAroundVectorByAngle4(*z, (double3) {0.0, 0.0, 1.0), tempVC.z};
}
#endif
