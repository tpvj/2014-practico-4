package ;

import flash.display.Bitmap;
import openfl.Assets;
import engine.*;


class Bala extends GameElement{

	var img:Animation;
	var explode:Animation;
	static var puntaje:Int=0;

	static var pool:Array<Bala>=null;
	static private var scene:GameScene;

	public static function init(scene:GameScene){
		if(pool==null){
			Bala.scene=scene;
			pool=new Array<Bala>();
			for(i in 0 ... 20){
				var b=new Bala();
				scene.hijos.push(b);
				scene.addChild(b);
				pool.push(b);
			}
		}		
	}

	public static function getBala():Bala{
		if(pool.length>0){
			var p=pool.pop();
			p.visible=true;
			p.explode.visible=false;
			p.img.visible=true;
			p.estado=0;
			return p;
		}
		return null;
	}

	////////////////////////////////////////////////

	private function new(){
		super();
		img = new Animation( Assets.getBitmapData("images/player_missile.png"), 1, 6);
		explode = new Animation( Assets.getBitmapData("images/player_missile_explode.png"), 1, 8);
		this.addChild(img);
		hijos.push(img);
		this.addChild(explode);
		hijos.push(explode);
		visible=false;
	}

	override public function updateLogic(time:Float){
		if(!visible) return;
		super.updateLogic(time);

		if(estado==1){
			if(explode.getFrame() == 7){
				this.visible=false;
				pool.push(this);
			}
			return;
		}

		this.x+=80*time;

		for(enemigo in scene.enemigosActivos){
			if(GameScene.detectarColision(this,enemigo)){
				this.estado=1;
				img.visible=false;
				explode.visible=true;
				explode.reset();
				enemigo.die();
				puntaje++;
				googleAnalytics.Stats.trackEvent('game','level-1','hit-enemy');		
				Persistence.setScore(puntaje);
			}
		}

		if(this.x>900){
			pool.push(this);
			this.visible=false;
		}
	}
	
}