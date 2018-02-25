/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Box Fold
 * This formula contains aux.color

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfBoxFoldIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfBoxFoldIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 oldZ = z;
	REAL colorAdd = 0.0;
	if (fabs(z.x) > fractal->mandelbox.foldingLimit)
	{
		z.x = mad(sign(z.x), fractal->mandelbox.foldingValue, -z.x);
	}
	if (fabs(z.y) > fractal->mandelbox.foldingLimit)
	{
		z.y = mad(sign(z.y), fractal->mandelbox.foldingValue, -z.y);
	}
	REAL zLimit = fractal->mandelbox.foldingLimit * fractal->transformCommon.scale1;
	REAL zValue = fractal->mandelbox.foldingValue * fractal->transformCommon.scale1;
	if (fabs(z.z) > zLimit)
	{
		z.z = mad(sign(z.z), zValue, -z.z);
	}
	if (fractal->foldColor.auxColorEnabledFalse)
	{
		if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor.x;
		if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor.y;
		if (z.z != oldZ.z) aux->color += fractal->mandelbox.color.factor.z;
	}

	// alternative 1
	if (fractal->transformCommon.functionEnabledCxFalse)
	{
		if (fabs(z.x) > fractal->mandelbox.foldingLimit)
		{
			colorAdd += fractal->mandelbox.color.factor.x;
		}
		else
		{
			colorAdd +=
				fractal->mandelbox.color.factor.x
				* (1.0f - (fractal->mandelbox.foldingLimit - fabs(z.x)) / fractal->mandelbox.foldingLimit);
		}

		if (fabs(z.y) > fractal->mandelbox.foldingLimit)
		{
			colorAdd += fractal->mandelbox.color.factor.y;
		}
		else
		{
			colorAdd +=
				fractal->mandelbox.color.factor.y
				* (1.0f - (fractal->mandelbox.foldingLimit - fabs(z.y)) / fractal->mandelbox.foldingLimit);
		}

		if (fabs(z.z) > fractal->mandelbox.foldingLimit)
		{
			colorAdd += fractal->mandelbox.color.factor.z;
		}
		else
		{
			colorAdd +=
				fractal->mandelbox.color.factor.z
				* (1.0f - (fractal->mandelbox.foldingLimit - fabs(z.z)) / fractal->mandelbox.foldingLimit);
		}
		aux->color += colorAdd;
	}

	// alternative 2
	if (fractal->transformCommon.functionEnabledCyFalse)
	{
		REAL valMinusLim = fractal->mandelbox.foldingValue - fractal->mandelbox.foldingLimit;
		if (z.x != oldZ.x)
		{
			colorAdd += fractal->mandelbox.color.factor.x * (fabs(z.x) - fractal->mandelbox.foldingLimit)
									/ valMinusLim;
		}
		if (z.y != oldZ.y)
		{
			colorAdd += fractal->mandelbox.color.factor.y * (fabs(z.y) - fractal->mandelbox.foldingLimit)
									/ valMinusLim;
		}
		if (z.z != oldZ.z)
		{
			colorAdd += fractal->mandelbox.color.factor.z * (fabs(z.z) - fractal->mandelbox.foldingLimit)
									/ valMinusLim;
		}
		aux->color += colorAdd;
	}
	return z;
}