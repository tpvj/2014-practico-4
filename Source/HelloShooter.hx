package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import engine.*;
import extension.admob.*;
/**
 * ...
 * @author fbricker
 */
class HelloShooter extends engine.SceneManager {

	private static var instance:SceneManager=null;
	public static function getInstance():SceneManager{
		return instance;
	}

	public function new () {
		super();
		AdMob.initAndroid("ca-app-pub-XXXXX123456","ca-app-pub-XXXXX123457", GravityMode.BOTTOM); // may also be GravityMode.TOP
        	AdMob.initIOS("ca-app-pub-XXXXX123458","ca-app-pub-XXXXX123459", GravityMode.BOTTOM); // may also be GravityMode.TOP

		googleAnalytics.Stats.init('UA-27265081-3', 'testing.sempaigames.com');
		instance=this;

		stage.addEventListener(flash.events.Event.ENTER_FRAME,gameLoop);
		InputManager.getInstance().suscribe(stage);

		sceneMap.set('game',new GameScene());
		sceneMap.set('menu',new MenuScene());
		//sceneMap.set('game',new GameScene());

		setScene('menu');
		googleAnalytics.Stats.trackEvent('menu','main-menu','open');
		stage.addEventListener(openfl.events.Event.RESIZE,onResize);
		AdMob.showBanner();
	}

	public function onResize(_){
		var s:Float=Math.min(stage.stageWidth/800,stage.stageHeight/600);
		this.scaleX=this.scaleY=s;
		this.x=(stage.stageWidth-800*s)/2;
		this.y=(stage.stageHeight-600*s)/2;
	}

	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e){
		this.updateLogic(1/60);
	}
		
}
