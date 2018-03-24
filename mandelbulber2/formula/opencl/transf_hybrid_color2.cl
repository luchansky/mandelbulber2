/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Hybrid Color Trial2
 *
 * for folds the aux.color is updated each iteration
 * depending on which slots have formulas that use it
 *
 *
 * bailout may need to be adjusted with some formulas

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfHybridColor2Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfHybridColor2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// REAL auxColor = 0.0f;
	REAL R2 = 0.0f;

	REAL distEst = 0.0f;
	// REAL XYZbias = 0.0f;
	REAL planeBias = 0.0f;
	// REAL divideByIter = 0.0f;
	// REAL radius = 0.0f;
	REAL linearOffset = 0.0f;
	// REAL factorR = fractal->mandelbox.color.factorR;
	REAL componentMaster = 0.0f;
	REAL minValue = 0.0f;
	// REAL4 lastPoint = aux->old_z;
	REAL lengthIter = 0.0f;
	REAL boxTrap = 0.0f;
	REAL sphereTrap = 0.0f;
	//	float sumDist = 0.0f;
	float lastDist = 0.0f;
	float addI = 0.0f;

	// used to turn off or mix with old hybrid color and orbit traps
	// aux->oldHybridFactor *= fractal->foldColor.oldScale1;
	// aux->minRFactor = fractal->foldColor.scaleC0; // orbit trap weight

	/*{ // length of last movement before termination
		REAL4 vecIter =  fabs(z - aux->old_z);
		lengthIter = length(vecIter) * aux->i; // (aux->i + 1.0f);
		aux->old_z = z;
	}*/
	// if (aux->i >= fractal->transformCommon.startIterationsD
	//&& aux->i < fractal->transformCommon.stopIterationsD)
	{
		// radius squared components
		if (fractal->transformCommon.functionEnabledRFalse)
		{
			REAL temp0 = 0.0f;
			REAL temp1 = 0.0f;
			REAL4 c = aux->c;
			temp0 = dot(c, c) * fractal->foldColor.scaleA0; // initial R2
			temp1 = dot(z, z) * fractal->foldColor.scaleB0;
			R2 = temp0 + temp1;
		}

		// total distance squared
		if (fractal->foldColor.distanceEnabledFalse)
		{
			if (aux->i >= fractal->transformCommon.startIterationsD
					&& aux->i < fractal->transformCommon.stopIterationsD)
			{
				REAL4 subVs = z - aux->old_z;
				// subVs *= fractal->foldColor.scaleB1;
				lastDist = dot(subVs, subVs) * fractal->foldColor.scaleB1;

				// lastDist = (z.z - aux->old_z.z) * fractal->foldColor.scaleB1;

				if (fractal->transformCommon.functionEnabledAxFalse)
				{
					subVs = fabs(subVs);
					lastDist = min(min(subVs.x, subVs.y), subVs.z) * fractal->foldColor.scaleB1;
				}
				else
					aux->addDist += lastDist;
			}

			lastDist = aux->addDist;

			// update
			aux->old_z = z;
		}
		/*aux->sum_z +=(z); // fabs
		REAL4 sumZ = aux->sum_z;
		sumDist = dot(sumZ, sumZ) * fractal->foldColor.scaleB1;*/

		/*	REAL4 subV = z - aux->old_z;
			subV = fabs(subV);
			// sumDist = max(max(subV.x, subV.y), subV.z);
			sumDist = min(min(subV.x, subV.y), subV.z) * native_divide(fractal->foldColor.scaleB1,
			10.0f);*/

		/*last distance

		{
			aux->sum_z +=(z); // fabs
			REAL4 sumZ = aux->sum_z;
			sumDist = dot(sumZ, sumZ) * fractal->foldColor.scaleB1;

			REAL4 subV = z - aux->old_z;
			lastDist = dot(subV, subV) * fractal->foldColor.scaleC1;

			// sumDist = max(max(subV.x, subV.y), subV.z);
			//sumDist = min(min(subV.x, subV.y), subV.z) * native_divide(fractal->foldColor.scaleB1,
		10.0f);

			// update
			aux->old_z = z;
		}*/

		// DE component
		if (fractal->transformCommon.functionEnabledDFalse)
		{
			if (fractal->transformCommon.functionEnabledBxFalse)
				distEst = aux->r_dz;
			else
				distEst = aux->DE;
			REAL temp5 = 0.0f;
			temp5 = distEst * fractal->foldColor.scaleD0;
			if (fractal->transformCommon.functionEnabledByFalse) temp5 *= native_recip((aux->i + 1.0f));
			if (fractal->transformCommon.functionEnabledBzFalse)
				temp5 *= native_recip((mad(aux->i, aux->i, 1.0f)));
			distEst = temp5;
		}

		// max linear offset
		if (fractal->transformCommon.functionEnabledMFalse)
		{
			REAL temp30 = 0.0f;
			REAL4 temp31 = z;
			if (fractal->transformCommon.functionEnabledM) temp31 = fabs(temp31);

			temp30 = max(max(temp31.x, temp31.y), temp31.z);
			temp30 *= fractal->foldColor.scaleA1;
			linearOffset = temp30;
		}

		// box trap
		if (fractal->surfBox.enabledX2False)
		{
			REAL4 box = fractal->transformCommon.scale3D444;
			REAL4 temp35 = z;
			REAL temp39 = 0.0f;

			if (fractal->transformCommon.functionEnabledCx) temp35 = fabs(temp35);

			temp35 = box - temp35;
			REAL temp36 = max(max(temp35.x, temp35.y), temp35.z);
			REAL temp37 = min(min(temp35.x, temp35.y), temp35.z);
			temp36 = mad(fractal->transformCommon.offsetB0, temp37, temp36);
			temp36 *= fractal->transformCommon.scaleC1;

			if (fractal->surfBox.enabledY2False)
			{
				REAL4 temp38 = aux->c;

				if (fractal->transformCommon.functionEnabledCz) temp38 = fabs(temp38);
				temp38 = box - temp38;

				temp39 = max(max(temp38.x, temp38.y), temp38.z);
				REAL temp40 = min(min(temp38.x, temp38.y), temp38.z);
				temp39 = mad(fractal->transformCommon.offsetA0, temp40, temp39);
				temp39 *= fractal->transformCommon.scaleE1;
			}
			boxTrap = temp36 + temp39;
		}

		// sphere trap
		if (fractal->transformCommon.functionEnabledzFalse)
		{
			REAL sphereR2 = fractal->transformCommon.maxR2d1;
			REAL temp45 = dot(z, z);
			REAL temp46 = sphereR2 - temp45;
			REAL temp47 = temp46;
			REAL temp51 = temp46;
			if (fractal->transformCommon.functionEnabledAx) temp51 = fabs(temp51);
			temp51 *= fractal->transformCommon.scaleF1;

			if (fractal->transformCommon.functionEnabledyFalse && temp45 > sphereR2)
			{
				temp46 *= temp46 * fractal->transformCommon.scaleG1;
			}
			if (fractal->transformCommon.functionEnabledPFalse && temp45 < sphereR2)
			{
				temp47 *= temp47 * fractal->transformCommon.scaleB1;
			}
			sphereTrap = temp51 + temp47 + temp46;
		}

		// plane bias
		if (fractal->transformCommon.functionEnabledAzFalse)
		{
			REAL4 tempP = z;
			if (fractal->transformCommon.functionEnabledEFalse)
			{
				tempP.x = tempP.x * tempP.y;
				tempP.x *= tempP.x;
			}
			else
			{
				tempP.x = fabs(tempP.x * tempP.y);
			}
			if (fractal->transformCommon.functionEnabledFFalse)
			{
				tempP.y = tempP.y * tempP.z;
				tempP.y *= tempP.y;
			}
			else
			{
				tempP.y = fabs(tempP.y * tempP.z);
			}

			if (fractal->transformCommon.functionEnabledKFalse)
			{
				tempP.z = tempP.z * tempP.x;
				tempP.z *= tempP.z;
			}
			else
			{
				tempP.z = fabs(tempP.z * tempP.x);
			}

			tempP = tempP * fractal->transformCommon.scale3D000;
			planeBias = tempP.x + tempP.y + tempP.z;
		}
		/*	if (fractal->transformCommon.functionEnabledCzFalse)
			{
				addI += (aux->i + 1.0f) * fractal->transformCommon.scale;
			}*/
	}
	// build  componentMaster
	componentMaster =
		(R2 + distEst + planeBias + lengthIter + linearOffset + boxTrap + addI + sphereTrap + lastDist);
	// divide by i option
	/*if (fractal->transformCommon.functionEnabledCzFalse
			&& aux->i >= fractal->transformCommon.startIterationsT
			&& aux->i < fractal->transformCommon.stopIterationsT)
	{
		int iUse = aux->i - fractal->transformCommon.startIterationsT;
		componentMaster += fractal->transformCommon.scale * iUse;
		//componentMaster += componentMaster * (1.0f + native_divide(fractal->transformCommon.scale,
	(aux->i + 1.0f)));
		//componentMaster += (aux->i + 1.0f) * fractal->transformCommon.scale;
	}*/

	// non-linear palette options
	// if (fractal->foldColor.parabEnabledFalse)
	//{ // parabolic
	// componentMaster += (componentMaster * componentMaster * fractal->foldColor.parabScale0);
	//}
	// if (fractal->foldColor.cosEnabledFalse)
	//{ // trig
	//	REAL trig = 128 * -fractal->foldColor.trigAdd1
	//								* (native_cos(componentMaster * 2.0f * native_divide(M_PI_F,
	//fractal->foldColor.period1)) - 1.0f);
	//	componentMaster += trig;
	//}
	if (fractal->transformCommon.functionEnabledAyFalse)
	{ // log
		REAL logCurve = log(componentMaster + 1.0f) * fractal->foldColor.scaleE0;
		componentMaster += logCurve;
	}

	// limit componentMaster
	// if (componentMaster < fractal->foldColor.limitMin0)
	//	componentMaster = fractal->foldColor.limitMin0;
	// if (componentMaster > fractal->foldColor.limitMax9999)
	// componentMaster = fractal->foldColor.limitMax9999;

	// final component value + cumulative??
	{
		// aux->colorHybrid =
		//	(componentMaster * 256.0f) ; //+ (lastColorValue );
	}
	// aux->temp100 *= fractal->transformCommon.scale0;

	componentMaster *= fractal->transformCommon.scaleA1;

	aux->colorHybrid = componentMaster;
	if (fractal->surfBox.enabledZ2False)
	{
		if (componentMaster < aux->temp100) // )
		{
			aux->temp100 = componentMaster;
		}
		minValue = aux->temp100;

		aux->colorHybrid += (minValue - aux->colorHybrid);
		//	mad(aux->colorHybrid, (1.0f - fractal->surfBox.scale1Z1), (minValue *
		// fractal->surfBox.scale1Z1));
	}
	return z;
}