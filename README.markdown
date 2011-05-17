# AS2/3 progress indicator class

**ProgressIndicator** is a simple progress indicator class which can draw different pre-defined shapes arranged in a circle.
I built it from scratch and tried to make it as CPU and memory efficient and easy to use as possible.

**You can use the tool to**
* give user feedback on form data submission process
* display it until you load something which doesn't require a proper 'percentage' preloader
* add to your existing (real) preloader
* display any other sort of preload or time process you like

**AS3 Compatible players:**
* Adobe Flash Player 9 or higher
* Adobe AIR Player 1.1 or higher

**AS2 Compatible players:**
* Adobe Flash Player 7 or higher
* Adobe FlashLite Player 2.0 or higher
* Adobe AIR Player 1.1 or higher

## Flexibility

The class is very easy to customize. You can choose from a number of different shapes and also set the density, the amount of shapes animated and faded, the speed of the animation, the radius and color.
Also, you can add any filters to it to make it cooler.

## Usage

**AS3 (default indicator):**
	
	import com.robertpataki.heartcode.ProgressIndicator;

	var preloader_sp:ProgressIndicator = new ProgressIndicator();
	preloader_sp.name = "preloader_sp";
	addChild(preloader_sp);
	preloader_sp.x = stage.stageWidth * 0.5;
	preloader_sp.y = stage.stageHeight * 0.5;

**AS2 (custom indicator):**
	
	import com.robertpataki.heartcode.ProgressIndicator;
	import flash.filters.BlurFilter;

	new ProgressIndicator(this, "preloader_mc", ProgressIndicator.SHAPE_CIRCLE, 40, 1, 0x00ffff, 12, 0.03, true);
	preloader_mc.filters = [new GlowFilter(0x00ffff, 0.6, 8, 8, 2, 2), new BlurFilter(2, 2, 2)];
	preloader_mc._x = Stage.width * 0.5;
	preloader_mc._y = Stage.height * 0.5;

## Credits

ProgressIndicator was created by Robert Pataki.

## License

**(The MIT License)**


Copyright (c) 2010-2011 Robert Pataki heartcode@robertpataki.com;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.