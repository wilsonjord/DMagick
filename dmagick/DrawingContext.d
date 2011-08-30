/**
 * Copyright: Mike Wey 2011
 * License:   zlib (See accompanying LICENSE file)
 * Authors:   Mike Wey
 */

module dmagick.DrawingContext;

import std.array;
import std.string;

import dmagick.Color;
import dmagick.Exception;
import dmagick.Geometry;
import dmagick.Image;
import dmagick.Options;
import dmagick.Utils;

import dmagick.c.draw;
import dmagick.c.geometry;
import dmagick.c.type;

/**
 * Drawable provides a convenient interface for preparing vector,
 * image, or text arguments.
 */
class DrawingContext
{
	string operations;

	/**
	 * Apply the drawing context to the image.
	 */
	void draw(Image image)
	{
		copyString(image.options.drawInfo.primitive, operations);
		DrawImage(image.imageRef, image.options.drawInfo);

		DMagickException.throwException(&(image.imageRef.exception));
	}

	/**
	 * Transforms the coordinate system by a 3x3 transformation matrix.
	 */
	void affine(AffineMatrix matrix)
	{
		operations ~= format(" affine %s,%s,%s,%s,%s,%s",
			matrix.sx, matrix.rx, matrix.ry, matrix.sy, matrix.tx, matrix.ty);
	}

	/**
	 * Draws an arc within a rectangle.
	 */
	void arc(size_t startX, size_t startY, size_t endX, size_t endY, double startDegrees, double endDegrees)
	{
		operations ~= format(" arc %s,%s %s,%s %s,%s",
			startX, startY, endX, endY, startDegrees, endDegrees);
	}

	/**
	 * Draw a cubic Bezier curve.
	 * 
	 * The arguments are pairs of points. At least 4 pairs must be specified.
	 * Each point xn, yn on the curve is associated with a control point
	 * cxn, cyn. The first point, x1, y1, is the starting point. The last
	 * point, xn, yn, is the ending point. Other point/control point pairs
	 * specify intermediate points on a polybezier curve.
	 */
	void bezier(size_t x1, size_t y1, size_t cx1, size_t cy1,
		size_t cx2, size_t cy2, size_t x2, size_t y2,
		size_t[] points ...)
	in
	{
		assert ( points.length % 2 == 0,
			"bezier needs an even number of argumants, "~
			"each x coordinate needs a coresponding y coordinate." );
	}
	body
	{
		operations ~= format(" bezier %s,%s %s,%s %s,%s %s,%s",
			x1, y1, cx1, cy1, cx2, cy2, x2, y2);

		for( int i = 0; i < points.length; i+=2 )
			operations ~= format(" %s,%s", points[i], points[i+1]);
	}

	void borderColor(Color color)
	{
		operations ~= format(" border-color %s", color);
	}

//clip-path
//clip-rule
//clip-units
//circle
//color
//decorate
//ellipse
//encoding
//fill
//fill-opacity
//fill-rule
//font
//font-family
//font-size
//font-stretch
//font-style
//font-weight
//gradient-units
//gravity
//image
//interline-spacing
//interword-spacing
//kerning
//line
//matte
//offset
//opacity
//path
//point
//polyline
//polygon
//pop
//push
//rectangle
//rotate
//roundRectangle
//scale
//skewX
//skewY
//stop-color
//stroke
//stroke-antialias
//stroke-dasharray
//stroke-dashoffset
//stroke-linecap
//stroke-linejoin
//stroke-miterlimit
//stroke-opacity
//stroke-width
//text
//text-align
//text-anchor
//text-antialias
//text-undercolor
//translate
//viewbox
}
