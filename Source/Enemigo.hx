package ;

import flash.display.Bitmap;
import openfl.Assets;
import engine.*;


class Enemigo extends GameElement{
	
	var volando:Animation;
	var scene:GameScene;

	public function new (scene:GameScene) {
		super();
		volando = new Animation( Assets.getBitmapData("images/brainy_idle.png"), 1, 8);
		this.addChild(volando);
		this.hijos.push(volando);
		this.scene=scene;
	}

	public function die(){
		estado=0;
		scene.enemigos.push(this);
		scene.enemigosActivos.remove(this);
		scene.hijos.remove(this);
		scene.removeChild(this);		
	}

	public function atack(){
		this.x=1000;
		this.y=50+Std.random(500);
		this.estado=1;
		scene.hijos.push(this);
		scene.addChild(this);
		scene.enemigosActivos.push(this);
	}
	
	override public function updateLogic(time:Float){
		if(estado==0) return;
		super.updateLogic(time);
		x-=time*50;
		if(x<-100) die();
	}

}
