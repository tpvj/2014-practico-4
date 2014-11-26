package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import engine.*;
/**
 * ...
 * @author fbricker
 */
class GameScene extends Scene {

	private var avion:Avion;
	public var enemigos(default,null):Array<Enemigo>;
	public var enemigosActivos(default,null):Array<Enemigo>;
	private var fondo1:FondoAnimado;
	private var fondo2:FondoAnimado;
	private var fondo3:FondoAnimado;
	private var enemyTimer:Float;
	var backBtn:Boton;

	public function new () {
		super();

		Bala.init(this);
		backBtn=new Boton(0xFFFFFF,function(_){HelloShooter.getInstance().setScene('menu');} );

		fondo1=new FondoAnimado('images/background1.png',10);
		fondo2=new FondoAnimado('images/background3.png',70);
		fondo3=new FondoAnimado('images/background5.png',150);
		
		addChild(fondo1);
		addChild(fondo2);
		addChild(fondo3);

		hijos.push(fondo1);
		hijos.push(fondo2);
		hijos.push(fondo3);

		enemigos=new Array<Enemigo>();
		enemigosActivos=new Array<Enemigo>();
		//Cargo los enemigos
		for(i in 0 ... 10) enemigos.push(new Enemigo(this));			

		avion = new Avion(this);
		
		// Los coloco en Pantalla
		this.addChild(avion);
		hijos.push(avion);

		enemyTimer=0;

		addChild(backBtn);
	}

	override public function show(){
		googleAnalytics.Stats.trackEvent('game','level-1','begin');		
	}


	override public function updateLogic(time:Float){
		super.updateLogic(time);
       	       	
		enemyTimer-=time;

		if(enemyTimer<0){
			enemyTimer=Std.random(3)+2;
			if(enemigos.length>0) enemigos.pop().atack();
		}
       	
	}

    // Detecta si obj1 y obj2 colisionan por el metodo mas simple de todos.
    public static function detectarColision(obj1:GameElement,obj2:GameElement):Bool{
		if(obj1.x+obj1.width>obj2.x && obj1.x<obj2.x+obj2.width){
		   	if(obj1.y+obj1.height>obj2.y && obj1.y<obj2.y+obj2.height){
		   		return true;
		   	}
		}
		return false;
    }
		
}
