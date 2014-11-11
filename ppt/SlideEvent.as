package  ppt{
	import flash.events.Event;
	
	public class SlideEvent extends Event {
		public static const FINISH:String = "finish";//an slide or mother is finished
		public static const PAGEOUT:String = "pageout";
		public static const COMPLETE:String = "complete";
		private var label_:String = null;

		public function SlideEvent(type:String, label:String=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.label_ = label;
		}
		public function label():String { return label_;}
		
		public override function clone():Event {
			return new SlideEvent(this.type, this.label_, this.bubbles, this.cancelable);
		}

	}
	
}
