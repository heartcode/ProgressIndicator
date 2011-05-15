﻿/*	Copyright (c) 2010 - 2011 Robert Pataki	Email:		heartcode@robertpataki.com	Web:		http://heartcode.robertpataki.com && http://www.robertpataki.com	See the documentation for more details and examples.	Permission is hereby granted, free of charge, to any person obtaining a copy	of this software and associated documentation files (the "Software"), to deal	in the Software without restriction, including without limitation the rights	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell	copies of the Software, and to permit persons to whom the Software is	furnished to do so, subject to the following conditions:	The above copyright notice and this permission notice shall be included in	all copies or substantial portions of the Software.	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN	THE SOFTWARE. * */import mx.utils.Delegate;/** * A simple preloader animation. The AS2 version has been optimized to run on mobile devices with lower processor and memory allocation.* <p>		 * <b>You can use it to</b>		 * <ul>		 * 	<li>give user feedback on form data submission process;</li>		 * 	<li>display it until you load something which doesn't require a proper 'percentage' preloader;</li>		 * 	<li>add to your existing (real) preloader;</li>		 * 	<li>display any other sort of preload or time process you like.</li>		 * </ul>	 * </p>	 * <p>		* <b>Compatible players:</b>		* <ul>		* 	<li>Adobe Flash Player 7 or higher</li>		*	<li>Adobe FlashLite Player 2.0 or higher</li>		*	<li>Adobe AIR Player 1.1 or higher</li>		* </ul>	 * </p> *  * <h2>Examples</h2> * <p><strong>Example 1: </strong> If the constructor is called without parameters it generates a default animation.</p> * {@code import com.robertpataki.heartcode.HCPreloaderAnim; *  * var preloader:HCPreloaderAnim = new HCPreloaderAnim(); * } * <p><img src="../../../images/hc/hcpreloaderanim_01.png" width="82" height="82" alt="hcpreloaderanim_01.png" /></p> *  * <br/> *  * <p><strong>Example 2: </strong>  The simple vector shapes could be much more fancy when some filters are applied.</p> * {@code import com.robertpataki.heartcode.HCPreloaderAnim; *  * new HCPreloaderAnim(this, "preloader_mc", HCPreloaderAnim.SHAPE_CIRCLE, 40, 1, 0x00ffff, 12, 0.03, true); * preloader_mc.filters = [new GlowFilter(0x00ffff, 0.6, 8, 8, 2, 2), new BlurFilter(2, 2, 2)]; *  * preloader_mc._x = Stage.width / 2; * preloader_mc._y = Stage.height / 2; * } * <p><img src="../../../images/hc/hcpreloaderanim_02.png" width="82" height="82" alt="hcpreloaderanim_02.png" /></p> * * @author Robert Pataki, heartcode@robertpataki.com */class com.robertpataki.heartcode.HCPreloaderAnim extends MovieClip {	private var _shape:String;	private var _density:Number;	private var _range:Number;	private var _radius:Number;	private var _frequency:Number;	private var _fade:Boolean;		public static var SHAPE_SQUARE:String			= "square";	public static var SHAPE_CIRCLE:String			= "circle";	public static var SHAPE_STAKE:String			= "stake";	public static var SHAPE_ELLIPSE:String			= "ellipse";	public static var SHAPE_TRIANGLE:String			= "triangle";		private static var defaultParent:MovieClip		= _root;	private static var defaultName:String			= "preloader_mc";	private static var defaultShape:String			= SHAPE_ELLIPSE;	private static var defaultDensity:Number		= 12;	private static var defaultRange:Number			= 0.8;	private static var defaultColor:Number			= 0x666666;	private static var defaultRadius:Number			= 14;	private static var defaultFrequency:Number		= 0.05;	private static var defaultFade:Boolean			= false;		private var shapes:Array;	private var intervalID:Number;	private var activeID:Number;	private var preloaderClip_mc:MovieClip;		/**	 * Creates a new preloader animation.	 * @param	parent The container MovieClip object. The default value is <code>_root</code>	 * @param	name The name of the Preloader instance. The default value is <code>"preloader_mc"</code>	 * @param	shape The shape of the preloader bits. The default value is <code>defaultShape</code>.	 * @param 	density Sets the fineness of the preloader. The default value is <code>12</code>.	 * @param 	range Sets the range of bits to be animated. The default value is <code>0.8</code>.	 * @param	color Sets the color of the preloader. The default value is <code>0x666666</code>.	 * @param	radius The radius of the circle the shapes are drawn around. The default value is <code>14</code>.	 * @param	frequency The refreshing frequency of each bit (in seconds). The default value is <code>0.05</code>.	 * @param	fade If set to true the non-animated bits of the preloader are invisible. This gives the  a nice dynamic look. The default value is <code>false</code>.	 * @see		#SHAPE_SQUARE	 * @see		#SHAPE_CIRCLE	 * @see		#SHAPE_STAKE	 * @see		#SHAPE_ELLIPSE	 * @see		#SHAPE_TRIANGLE	*/	public function HCPreloaderAnim(parent:MovieClip, name:String, shape:String, density:Number, range:Number, color:Number, radius:Number, frequency:Number, fade:Boolean)	{		_parent = MovieClip(parent) != undefined ? MovieClip(parent) : defaultParent;		_name = name != undefined && name != "" ? name : defaultName;		_shape = shape != undefined && shape != "" ? shape : defaultShape;		_density = density != undefined ? density : defaultDensity;		_range = range != undefined ? range : defaultRange;		_radius = radius != undefined ? radius : defaultRadius;		_frequency = frequency != undefined ? frequency : defaultFrequency;		_fade = fade != undefined ? fade : defaultFade;				color = color != undefined ? color : defaultColor;				preloaderClip_mc = _parent.createEmptyMovieClip(_name, _parent.getNextHighestDepth());				shapes = new Array();				var i:Number = 0;		for (; i < _density; i++ )		{			var radians:Number = i * ((Math.PI * 2) / _density);			var degrees:Number = radians / (Math.PI / 180) + 90;			var shape_mc:MovieClip = preloaderClip_mc.createEmptyMovieClip("shape" + i + "_mc", preloaderClip_mc.getNextHighestDepth());			shape_mc._alpha = 0;			shapes[i] = shape_mc;						shape_mc.beginFill(color);			switch(_shape)			{				case SHAPE_SQUARE:					drawRect(i);					shape_mc._rotation = degrees;				break;				case SHAPE_CIRCLE:					drawCircle(i);				break;				case SHAPE_STAKE:					drawStake(i);					shape_mc._rotation = degrees;				break;				case SHAPE_ELLIPSE:					drawEllipse(i);					shape_mc._rotation = degrees;				break;				case SHAPE_TRIANGLE:					drawTriangle(i);					shape_mc._rotation = degrees + 90;				break;			}			shape_mc.endFill();			shape_mc.cacheAsBitmap = true;						shape_mc._x = Math.cos(radians) * _radius;			shape_mc._y = Math.sin(radians) * _radius;		}				if (shape == undefined)		{			preloaderClip_mc._x = Math.round(Stage.width / 2);			preloaderClip_mc._y = Math.round(Stage.height / 2);						trace("\n\tMessage from HCPreloaderAnim :\n\t | Some of the parameters are missing!\n\t | An auto-generated preloader animation has been added to the _root object.\n\t | See the documentation for more details and examples.\n\tEnd of line.\n");		}				enabled = false;				activeID = 0;		refresh();		addTimer();	};///////////////////////////////////////////////////////////////////////////////////////////////////// Draw functions///////////////////////////////////////////////////////////////////////////////////////////////////	/**	 * Draws a rectangular shape.	 * */	private function drawRect(id:Number):Void	{		shapes[id].moveTo( -_radius * 0.15, -_radius * 0.15);		shapes[id].lineTo( _radius * 0.15, - _radius * 0.15);		shapes[id].lineTo( _radius * 0.15, _radius * 0.15);		shapes[id].lineTo( -_radius * 0.15, _radius * 0.15);		shapes[id].lineTo( -_radius * 0.15, -_radius * 0.15);	};		/**	 * Draws a circle shape.	 * */	private function drawCircle(id:Number):Void	{		shapes[id].moveTo(-_radius * 0.2, 0);		shapes[id].curveTo(- _radius * 0.2, - _radius * 0.2, 0, - _radius * 0.2);		shapes[id].curveTo(_radius * 0.2, - _radius * 0.2, _radius * 0.2, 0);		shapes[id].curveTo(_radius * 0.2, _radius * 0.2, 0, _radius * 0.2);		shapes[id].curveTo(- _radius * 0.2, _radius * 0.2, -_radius * 0.2, 0);	};		/**	 * Draws a stake shape.	 * */	private function drawStake(id:Number):Void	{		shapes[id].lineTo( -_radius * 0.15, -_radius * .85);		shapes[id].curveTo(-_radius * 0.15, -_radius, 0, -_radius);		shapes[id].curveTo(_radius * 0.15, -_radius, _radius * 0.15, -_radius * 0.85);		shapes[id].lineTo( _radius * 0.15, -_radius * .85);		shapes[id].lineTo(0, 0);	};		/**	 * Draws an ellipse shape.	 * */	private function drawEllipse(id:Number):Void	{		shapes[id].moveTo(-_radius * 0.15, 0);		shapes[id].curveTo(-_radius*0.15, -_radius*0.35, 0, -_radius*0.35);		shapes[id].curveTo(_radius*0.15, -_radius*0.35, _radius*0.15, 0);		shapes[id].curveTo(_radius*0.15, _radius*0.35, 0, _radius*0.35);		shapes[id].curveTo(-_radius*0.15, _radius*0.35, -_radius*0.15, 0);	};		/**	 * Draws a triangle shape.	 * */	private function drawTriangle(id:Number):Void	{		shapes[id].moveTo(0, _radius * 0.15);		shapes[id].lineTo(-_radius * 0.15, _radius * 0.15);		shapes[id].lineTo(0, -_radius * 0.15);		shapes[id].lineTo(_radius * 0.15, _radius*0.15);		shapes[id].lineTo(0, _radius*0.15);	};	///////////////////////////////////////////////////////////////////////////////////////////////////// Animation functions///////////////////////////////////////////////////////////////////////////////////////////////////					/**	 * Animates the shapes.	 */	private function refresh():Void	{				var animBits:Number = Math.round(_density * _range);		var minBitMod:Number = 1/animBits;		var bitMod:Number;				var i:Number = -1;		for (; shapes[++i]; )		{			var shape_mc:MovieClip = MovieClip(shapes[i]);			var distance:Number = i - activeID;			if (distance < 0) distance += _density;						if(distance <= animBits)			{				bitMod =  distance * minBitMod >= minBitMod ? distance * minBitMod : minBitMod;			}			else			{				bitMod = _fade ? 0 : minBitMod;			}						shape_mc._alpha = bitMod * 100;			if(_shape == SHAPE_CIRCLE) shape_mc._xscale = shape_mc._yscale = bitMod * 100;		}				if(activeID < _density-1)		{			++activeID;		}		else		{			refreshComplete();		}	};		/**	 * Restarts the timer.	 * */	private function refreshComplete():Void	{		activeID = 0;		removeTimer();		addTimer();	};		/**	 * Adds a new setInterval instance.	 * */	private function addTimer():Void	{		intervalID = setInterval(Delegate.create(this, refresh), _frequency*1000);	};		/**	 * Removes the setInterval instance.	 * */	private function removeTimer():Void	{		clearInterval(intervalID);		delete intervalID;	};	///////////////////////////////////////////////////////////////////////////////////////////////////// Control functions///////////////////////////////////////////////////////////////////////////////////////////////////					/**	 * Pauses or resumes the animation.	 * */	public function togglePause():Void	{		if (intervalID)		{			removeTimer();		}		else		{			addTimer();		}	};		/**	 * Kills the preloader.	 * */	public function kill():Void	{		removeTimer();				var i:Number=-1;		for(;shapes[++i];)		{			shapes[i].removeMovieClip();			delete shapes[i];			shapes[i] = null;		}		shapes = null;				MovieClip(_parent[_name]).removeMovieClip();	};};