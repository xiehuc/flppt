package  ppt{
	import com.greensock.TimelineLite;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.display.Stage;
	
	public class MotionManager extends EventDispatcher{
		private var timeline:TimelineLite;
		private var focus:MovieClip;
		private var forceLabel:String;
		private var otherFocus:Array;
		public const STATE_BLOCK:uint = 0
		public const STATE_WAIT:uint = 1;
		public const STATE_WAKE:uint = 2;
		public var state:uint;

		public function MotionManager() {
			timeline = new TimelineLite();
			state = STATE_BLOCK;
		}
		public function focusOn(m:*,force:String=null):void
		{
			if(m is MovieClip){
				var movie:MovieClip = m as MovieClip;
				focus = movie;
				otherFocus = [];
			}else if(m is Array){
				var a:Array = m as Array;
				focus = a.shift();
				otherFocus = a;
			}
			this.forceLabel = force;
			state = STATE_WAIT;
		}
		public function next():void 
		{
			state = STATE_WAKE;
			if(focus.enter == undefined){
				focus.dispatchEvent(new Event("finish"));
			} else if(focus.enter.totalProgress() == 1){
				focus.dispatchEvent(new Event("finish"));
			} else {
				focus.enter.play(forceLabel);
				for each(var m:MovieClip in otherFocus){
					if(m.enter) m.enter.play(forceLabel);
				}
			}
		}
		public function registEvent(stage:Stage):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, fl_changeSlideKeyboard);
			stage.addEventListener(MouseEvent.CLICK, fl_changeSlideMouse);
		}
		private function fl_changeSlideKeyboard(evt:KeyboardEvent):void
		{
			if(evt.keyCode == 37) // LEFT
			{
				//prev();
			}
			else if (evt.keyCode == 39 || evt.keyCode == 32) // RIGHT OR SPACE
			{
				next();
			}
		}
		private function fl_changeSlideMouse(e:MouseEvent):void
		{
			next();
		}
	}
	
}
