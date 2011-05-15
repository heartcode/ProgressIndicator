﻿/*	Copyright (c) 2010 - 2011 Robert Pataki	Email:		heartcode@robertpataki.com	Web:		http://heartcode.robertpataki.com && http://www.robertpataki.com	See the documentation for more details and examples.	Permission is hereby granted, free of charge, to any person obtaining a copy	of this software and associated documentation files (the "Software"), to deal	in the Software without restriction, including without limitation the rights	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell	copies of the Software, and to permit persons to whom the Software is	furnished to do so, subject to the following conditions:	The above copyright notice and this permission notice shall be included in	all copies or substantial portions of the Software.	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN	THE SOFTWARE. * */package com.robertpataki.heartcode{	import flash.display.Shape;	import flash.display.Sprite;	import flash.utils.Timer;	import flash.events.TimerEvent;		/**	 * A simple preloader animation.	 * <p>		 * <b>You can use it to</b>		 * <ul>		 * 	<li>give user feedback on form data submission process;</li>		 * 	<li>display it until you load something which doesn't require a proper 'percentage' preloader;</li>		 * 	<li>add to your existing (real) preloader;</li>		 * 	<li>display any other sort of preload or time process you like.</li>		 * </ul>	 * </p>	 * <p>		* <b>Compatible players:</b>		* <ul>		* 	<li>Adobe Flash Player 9 or higher</li>		*	<li>Adobe AIR Player 1.1 or higher</li>		* </ul>	 * </p>	 * 	 * @example <b>Example 1:</b> If the constructor is called without parameters it generates a default animation.	 * 	 * <listing version="3.0">	 * 	 * <code>	 * import com.robertpataki.heartcode.HCPreloaderAnim;	 * 	 * var preloader_sp:HCPreloaderAnim = new HCPreloaderAnim();	 * preloader_sp.name = "preloader_sp";	 * addChild(preloader_sp);	 * preloader_sp.x = stage.stageWidth / 2;	 * preloader_sp.y = stage.stageHeight / 2;	 * 	 * </code>	 * 	 * </listing>	 * <p><img src="../../../images/hc/hcpreloaderanim_01.png" width="82" height="82" alt="hcpreloaderanim_01.png" /></p>	 * 	 * @example <b>Example 2:</b> The simple vector shapes could be much more fancy when some filters are applied.	 * 	 * <listing version="3.0">	 * 	 * <code>	 * import com.robertpataki.heartcode.HCPreloaderAnim;	 * import flash.filters.BlurFilter;	 * import flash.filters.GlowFilter;	 * 	 * var preloader_sp:HCPreloaderAnim = new HCPreloaderAnim(HCPreloaderAnim.SHAPE_CIRCLE, 40, 1, 0x00ffff, 12, 0.03, true);	 * preloader_sp.name = "preloader_sp";	 * addChild(preloader_sp);	 * 	 * preloader_sp.filters = [new GlowFilter(0x00ffff, 0.6, 8, 8, 2, 2), new BlurFilter(2, 2, 2)];	 * preloader_sp.x = stage.stageWidth / 2;	 * preloader_sp.y = stage.stageHeight / 2;	 * 	 * </code>	 * 	 * </listing>	 * <p><img src="../../../images/hc/hcpreloaderanim_02.png" width="82" height="82" alt="hcpreloaderanim_02.png" /></p>	 *	 * @author Robert Pataki, heartcode@robertpataki.com	 */	public class HCPreloaderAnim extends Sprite	{				private var _shape:String;		private var _density:Number;		private var _range:Number;		private var _radius:uint;		private var _frequency:Number;		private var _fade:Boolean;				public static const SHAPE_SQUARE:String			= "square";		public static const SHAPE_CIRCLE:String			= "circle";		public static const SHAPE_STAKE:String			= "stake";		public static const SHAPE_ELLIPSE:String		= "ellipse";		public static const SHAPE_TRIANGLE:String		= "triangle";				public static const DEFAULT_SHAPE:String		= SHAPE_ELLIPSE;		public static const DEFAULT_DENSITY:uint		= 12;		public static const DEFAULT_RANGE:Number		= 0.8;		public static const DEFAULT_COLOR:Number		= 0x666666;		public static const DEFAULT_RADIUS:uint			= 14;		public static const DEFAULT_FREQUENCY:Number	= 0.05;		public static const DEFAULT_FADE:Boolean		= false;				private var shapes:Array;		private var timer:Timer;		private var activeID:uint;				/**		 * Creates a new preloader animation.		 * @param	shape The shape of the preloader bits. The default value is <code>DEFAULT_SHAPE</code>		 * @param 	density Sets the fineness of the preloader. The default value is <code>DEFAULT_DENSITY</code>		 * @param 	range Sets the range of bits to be animated. The default value is <code>DEFAULT_RANGE</code>		 * @param	color Sets the color of the preloader. The default value is <code>DEFAULT_COLOR</code>		 * @param	radius The radius of the circle the shapes are drawn around. The default value is <code>DEFAULT_RADIUS</code>		 * @param	frequency The refreshing frequency of each bit (in seconds). The default value is <code>DEFAULT_FREQUENCY</code>		 * @param	fade If set to true the non-animated bits of the preloader are invisible. This gives the preloader a nice dynamic look. The default value is <code>DEFAULT_FADE</code>		 * @see		#DEFAULT_SHAPE		 * @see		#DEFAULT_DENSITY		 * @see		#DEFAULT_RANGE		 * @see		#DEFAULT_COLOR		 * @see		#DEFAULT_RADIUS		 * @see		#DEFAULT_FREQUENCY		 * @see		#DEFAULT_FADE		 * @see		#SHAPE_SQUARE		 * @see		#SHAPE_CIRCLE		 * @see		#SHAPE_STAKE		 * @see		#SHAPE_ELLIPSE		 * @see		#SHAPE_TRIANGLE		*/		public function HCPreloaderAnim(shape:String=DEFAULT_SHAPE, density:uint=DEFAULT_DENSITY, range:Number=DEFAULT_RANGE, color:Number=DEFAULT_COLOR, radius:uint=DEFAULT_RADIUS, frequency:Number=DEFAULT_FREQUENCY, fade:Boolean=DEFAULT_FADE)		{						if(shape==DEFAULT_SHAPE && density==DEFAULT_DENSITY && range==DEFAULT_RANGE && color==DEFAULT_COLOR && radius==DEFAULT_RADIUS && frequency==DEFAULT_FREQUENCY && fade==DEFAULT_FADE) trace("\n\tMessage from HCPreloaderAnim :\n\t | Some of the parameters are missing!\n\t | An auto-generated preloader animation has been created.\n\t | See the documentation for more details and examples.\n\tEnd of line.\n");						_shape = shape;			_density = density;			_range = range;			_radius = radius;			_frequency = frequency;			_fade = fade;						shapes = new Array();						var i:uint = 0;			for (; i < _density; i++ )			{				var radians:Number = i * ((Math.PI * 2) / _density);				var degrees:Number = radians / (Math.PI / 180) + 90;				var shape_sh:Shape = new Shape();				shape_sh.name = "shape" + i + "_sh";				shape_sh.alpha = 0;				shapes[i] = shape_sh;				shape_sh.graphics.beginFill(color, 1);				switch(shape)				{					case SHAPE_SQUARE:						drawRect(i);						shape_sh.rotation = degrees;					break;					case SHAPE_CIRCLE:						drawCircle(i);					break;					case SHAPE_STAKE:						drawStake(i);						shape_sh.rotation = degrees;					break;					case SHAPE_ELLIPSE:						drawEllipse(i);						shape_sh.rotation = degrees;					break;					case SHAPE_TRIANGLE:						drawTriangle(i);						shape_sh.rotation = degrees + 90;					break;				}				shape_sh.graphics.endFill();				shape_sh.cacheAsBitmap = true;				shape_sh.x = Math.cos(radians) * _radius;				shape_sh.y = Math.sin(radians) * _radius;				addChild(shape_sh);			}						mouseChildren = mouseEnabled = false;						refresh();						addTimer();		};///////////////////////////////////////////////////////////////////////////////////////////////////// Draw functions///////////////////////////////////////////////////////////////////////////////////////////////////				/**		 * @private		 * Draws a rectangular shape.		 * */		private function drawRect(id:uint):void		{			shapes[id].graphics.drawRect( -_radius*0.15, -_radius*0.15, _radius*0.3, _radius*0.3);		};				/**		 * @private		 * Draws a circle shape.		 * */		private function drawCircle(id:uint):void		{			shapes[id].graphics.drawCircle(0, 0, _radius * 0.2);		};				/**		 * @private		 * Draws a stake shape.		 * */		private function drawStake(id:uint):void		{			shapes[id].graphics.lineTo( -_radius * 0.15, -_radius * .85);			shapes[id].graphics.curveTo(-_radius * 0.15, -_radius, 0, -_radius);			shapes[id].graphics.curveTo(_radius * 0.15, -_radius, _radius * 0.15, -_radius * 0.85);			shapes[id].graphics.lineTo( _radius * 0.15, -_radius * .85);			shapes[id].graphics.lineTo(0, 0);		};				/**		 * @private		 * Draws an ellipse shape.		 * */		private function drawEllipse(id:uint):void		{			shapes[id].graphics.moveTo(-_radius * 0.15, 0);			shapes[id].graphics.curveTo(-_radius*0.15, -_radius*0.35, 0, -_radius*0.35);			shapes[id].graphics.curveTo(_radius*0.15, -_radius*0.35, _radius*0.15, 0);			shapes[id].graphics.curveTo(_radius*0.15, _radius*0.35, 0, _radius*0.35);			shapes[id].graphics.curveTo(-_radius*0.15, _radius*0.35, -_radius*0.15, 0);		};				/**		 * @private		 * Draws a triangle shape.		 * */		private function drawTriangle(id:uint):void		{			shapes[id].graphics.moveTo(0, _radius * 0.15);			shapes[id].graphics.lineTo(-_radius * 0.15, _radius * 0.15);			shapes[id].graphics.lineTo(0, -_radius * 0.15);			shapes[id].graphics.lineTo(_radius * 0.15, _radius*0.15);			shapes[id].graphics.lineTo(0, _radius*0.15);		};		///////////////////////////////////////////////////////////////////////////////////////////////////// Animation functions///////////////////////////////////////////////////////////////////////////////////////////////////							/**		 * @private		 * Animates the shapes.		 * @param	event TimerEvent		 * @see #event:TimerEvent.TIMER		 */		private function refresh(event:TimerEvent=null):void		{						var animBits:Number = Math.round(_density * _range);			var minBitMod:Number = 1/animBits;			var bitMod:Number;						var i:int = -1;			for (; shapes[++i]; )			{				var shape_sh:Shape = Shape(shapes[i]);				var distance:int = i - activeID;				if (distance < 0) distance += _density;								if(distance <= animBits)				{					bitMod =  distance * minBitMod >= minBitMod ? distance * minBitMod : minBitMod;				}				else				{					bitMod = _fade ? 0 : minBitMod;				}								shape_sh.alpha = bitMod;				if(_shape == SHAPE_CIRCLE) shape_sh.scaleX = shape_sh.scaleY = bitMod;			}						++activeID;		};				/**		 * @private		 * Restarts the animation after one animation sequence.		 * @param	event TimerEvent		 * @see #event:TimerEvent.TIMER_COMPLETE		 */		private function refreshComplete(event:TimerEvent):void		{			activeID = 0;			removeTimer();			addTimer();		};				/**		 * @private		 * Adds a new Timer instance.		 * @see #class:Timer		 * */		private function addTimer():void		{			timer = new Timer(_frequency * 1000, _density);			timer.addEventListener(TimerEvent.TIMER, refresh);			timer.addEventListener(TimerEvent.TIMER_COMPLETE, refreshComplete);			timer.start();		};		/**		 * @private		 * Removes the Timer instance.		 * @see #class:Timer		 * */		private function removeTimer():void		{			timer.removeEventListener(TimerEvent.TIMER, refresh);			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, refreshComplete);			timer.stop();			timer = null;		};		///////////////////////////////////////////////////////////////////////////////////////////////////// Control functions///////////////////////////////////////////////////////////////////////////////////////////////////						/**		 * Kills the preloader.		 * */		public function kill():void		{			removeTimer();						var i:int=-1;			for(;shapes[++i];)			{				removeChild(shapes[i]);				shapes[i] = null;			}			shapes = null;		};	};	};