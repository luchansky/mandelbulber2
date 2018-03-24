/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * aBoxMod2, a variation of the Mandelbox fractal known as AmazingBox or ABox,
 * invented by Tom Lowe in 2010, this variation by DarkBeam
 *
 * The formula Cylinder Half Size transform changes the spherical fold
 * In V2.11 minimum radius is MinimumR2, for settings made in
 * older versions, you need to use the square root of the old parameter.
 * V.12 added full Mbox color controls
 *
 * based on DarkBeam's Mandelbulb3D code
 *
 * @reference
 * http://www.fractalforums.com/ifs-iterated-function-systems/amazing-fractal/msg12467/#msg12467
 * This formula contains aux.color and aux.actualScale

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "AboxMod2Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 AboxMod2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;
	aux->actualScale = mad(
		(fabs(aux->actualScale) - 1.0f), fractal->mandelboxVary4D.scaleVary, fractal->mandelbox.scale);
	// Tglad Fold
	REAL4 oldZ = z;
	z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
				- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
	z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
				- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
	if (fractal->transformCommon.functionEnabledM)
	{
		z.z = fabs(z.z + fractal->transformCommon.additionConstant111.z)
					- fabs(z.z - fractal->transformCommon.additionConstant111.z) - z.z;
	}
	if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor.x;
	if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor.y;
	if (z.z != oldZ.z) aux->color += fractal->mandelbox.color.factor.z;
	/*	REAL rr;
		if (temp > 0.0f)
			rr = mad(z.z, z.z, mad(z.x, z.x, z.y * z.y)); // on top & bottom of cyl. z.z should be tempZ
		else
			rr = mad(z.x, z.x, z.y * z.y); // on cyl body*/
	// cylinder half size
	REAL tempZ = fabs(z.z) - fractal->transformCommon.offset05;
	REAL rr = mad(z.x, z.x, z.y * z.y);
	if (tempZ > 0.0f) rr = rr + (tempZ * tempZ * fractal->transformCommon.scale1);
	// rPower
	if (fractal->transformCommon.functionEnabledFalse)
	{
		rr = native_powr(rr, fractal->mandelboxVary4D.rPower);
	}
	// Spherical Fold
	if (rr < fractal->transformCommon.minR2p25)
	{
		z *= fractal->transformCommon.maxMinR2factor;
		aux->DE *= fractal->transformCommon.maxMinR2factor;
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (rr < fractal->transformCommon.maxR2d1)
	{
		REAL tglad_factor2 = native_divide(fractal->transformCommon.maxR2d1, rr);
		z *= tglad_factor2;
		aux->DE *= tglad_factor2;
		aux->color += fractal->mandelbox.color.factorSp2;
	}
	// Scale
	z *= aux->actualScale;
	aux->DE = mad(aux->DE, fabs(aux->actualScale), 1.0f);

	// addCpixel
	if (fractal->transformCommon.addCpixelEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
	{
		REAL4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){c.z, c.y, c.x, c.w}; break;
			}
		}
		z += tempC * fractal->transformCommon.constantMultiplier111;
	}
	// rotation
	if (fractal->transformCommon.rotationEnabled
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	aux->foldFactor = fractal->foldColor.compFold; // fold group weight
	aux->minRFactor = fractal->foldColor.compMinR; // orbit trap weight

	REAL scaleColor = fractal->foldColor.colorMin + fabs(aux->actualScale); // scale, useScale, m, etc
	// scaleColor += fabs(fractal->mandelbox.scale);
	aux->scaleFactor = scaleColor * fractal->foldColor.compScale;
	return z;
}