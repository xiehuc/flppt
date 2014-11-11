package  ppt{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.StageScaleMode;
	import fl.transitions.*;
	import com.greensock.TimelineLite;
	import flash.events.Event;
	
	public class PPT {
		private var mother:MovieClip;
		private var slides:MovieClip;
		private var transitionOn:Boolean = true;
		private var transitionType:String = "Fade";
		private var isPageOut:Boolean = false;
		private var mm:MotionManager;

		public function PPT() {
			mm = new MotionManager();
		}
		public function setup(slides:MovieClip):void
		{
			this.slides = slides;
			var stage = slides.stage;
			mm.registEvent(stage);
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			slides.addEventListener("finish", slides_finish);
			slides.addEventListener("pageout", slides_pageout);
			slides.addEventListener("nomother", slides_nomother);
			//prev_btn.addEventListener(MouseEvent.CLICK, fl_prevSlideButton);
			//next_btn.addEventListener(MouseEvent.CLICK, fl_nextSlideButton);
			
		}
		public function motherBoard(m:MovieClip):void 
		{
			this.mother = m;
			m.addEventListener("finish", mother_finish);
			m.addEventListener("pageout", mother_pageout);
		}
		public function play():void 
		{
			slides.gotoAndStop(1);
		}
		private function fl_doTransition():void
		{
			if(transitionType == "Blinds")
			{
				TransitionManager.start(slides, {type:Blinds, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "Fade")
			{
				TransitionManager.start(slides, {type:Fade, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "Fly")
			{
				TransitionManager.start(slides, {type:Fly, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "Iris")
			{
				TransitionManager.start(slides, {type:Iris, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "Photo")
			{
				TransitionManager.start(slides, {type:Photo, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "PixelDissolve")
			{
				TransitionManager.start(slides, {type:PixelDissolve, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "Rotate")
			{
				TransitionManager.start(slides, {type:Rotate, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "Squeeze")
			{
				TransitionManager.start(slides, {type:Squeeze, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "Wipe")
			{
				TransitionManager.start(slides, {type:Wipe, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "Zoom")
			{
				TransitionManager.start(slides, {type:Zoom, direction:Transition.IN, duration:0.25});
			} else if (transitionType == "Random")
			{
				var randomNumber:Number = Math.round(Math.random()*9) + 1;
				switch (randomNumber) {
					case 1:
						TransitionManager.start(slides, {type:Blinds, direction:Transition.IN, duration:0.25});
						break;
					case 2:
						TransitionManager.start(slides, {type:Fade, direction:Transition.IN, duration:0.25});
						break;
					case 3:
						TransitionManager.start(slides, {type:Fly, direction:Transition.IN, duration:0.25});
						break;
					case 4:
						TransitionManager.start(slides, {type:Iris, direction:Transition.IN, duration:0.25});
						break;
					case 5:
						TransitionManager.start(slides, {type:Photo, direction:Transition.IN, duration:0.25});
						break;
					case 6:
						TransitionManager.start(slides, {type:PixelDissolve, direction:Transition.IN, duration:0.25});
						break;
					case 7:
						TransitionManager.start(slides, {type:Rotate, direction:Transition.IN, duration:0.25});
						break;
					case 8:
						TransitionManager.start(slides, {type:Squeeze, direction:Transition.IN, duration:0.25});
						break;
					case 9:
						TransitionManager.start(slides, {type:Wipe, direction:Transition.IN, duration:0.25});
						break;
					case 10:
						TransitionManager.start(slides, {type:Zoom, direction:Transition.IN, duration:0.25});
						break;
				}
			} else
			{
				trace("error - transitionType not recognized");
			}
		}
		
		// FUNCTIONS AND LOGIC
		private function fl_prevSlide():void
		{
			if(slides.currentFrame > 1)
			{
				slides.gotoAndStop(slides.currentFrame-1);
				if(transitionOn == true)
				{
					fl_doTransition();
				}
			}
		}
		private function fl_nextSlide():void
		{
			if(slides.currentFrame < slides.totalFrames)
			{
				slides.gotoAndStop(slides.currentFrame+1);
				mm.focusOn(slides);
				mm.next();
			}
		}
		private function fl_nextTheme():void
		{
			if(slides.currentFrame < slides.totalFrames)
			{
				slides.gotoAndStop(slides.currentFrame+1);
				slides.enter.pause();
				mother.visible = true;
				slides.visible = false;
				mother.enter.restart();
				mother.title.text = slides.currentFrameLabel==null?"":slides.currentFrameLabel;
			}
		}
		private function mother_finish(e:Event):void
		{
			if(mother.enter.totalProgress()==1){
				fl_nextTheme();
			}else{
				slides.visible = true;
				mm.focusOn(slides);
				mm.next();
			}
		}
		private function mother_pageout(e:Event):void
		{
			slides.visible = true;
		}
		private function slides_finish(e:Event):void
		{
			if(isPageOut){
				fl_nextSlide();
				isPageOut = false;
				return;
			}
			if(mother.visible == false){
				if(mm.state == mm.STATE_WAKE)
					fl_nextTheme();
				else
					mm.focusOn(slides);
				return;
			}
			mm.focusOn([mother,slides]);
		}
		private function slides_pageout(e:SlideEvent):void
		{
			isPageOut = true;
			mm.focusOn(slides, e.label());
		}
		private function slides_nomother(e:Event): void
		{
			mother.visible = false;
			mm.focusOn(slides);
		}
		private function fl_prevSlideButton(evt:MouseEvent):void
		{
			fl_prevSlide();
		}
		private function fl_nextSlideButton(evt:MouseEvent):void
		{
			fl_nextSlide();
		}
	}
	
}
