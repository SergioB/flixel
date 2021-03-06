package flixel.animation;

import flixel.FlxSprite;

/**
 * ...
 * @author Zaphod
 */
class FlxBaseAnimation
{
	/**
	 * Animation controller this animation belongs to
	 */
	public var parent:FlxAnimationController;
	
	/**
	 * String name of the animation (e.g. "walk")
	 */
	public var name:String;
	
	/**
	 * Keeps track of the current index into the tile sheet based on animation or rotation.
	 * Allow access to private var from FlxAnimationController.
	 */
	public var curIndex(default, set):Int = 0;
	
	private function set_curIndex(Value:Int):Int
	{
		curIndex = Value;
		
		if (parent != null && parent._curAnim == this)
		{
			parent.frameIndex = Value;
		}
		
		return Value;
	}
	
	public function new(Parent:FlxAnimationController, Name:String)
	{
		parent = Parent;
		name = Name;
	}
	
	public function destroy():Void
	{
		parent = null;
	}
	
	public function update():Void
	{
		
	}
	
	public function clone(Parent:FlxAnimationController):FlxBaseAnimation
	{
		return null;
	}
	
}