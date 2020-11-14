package game;

import ash.core.Entity;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;
import ash.core.Node;
import ashextension.*;
import js.jquery.*;
import whiplash.phaser.*;
import whiplash.math.*;
import js.Browser.window;
import js.Browser.document;

class Game extends whiplash.Application {
    static public var instance:Game;

    static function main():Void {
        new Game();
    }

    public function new() {
        var config = {
            render:{
                transparent:false
            },
            scale : {
                mode: phaser.scale.scalemodes.NONE
            },
            backgroundColor:"#000000"
        };
        super(Config.screen.width, Config.screen.height, ".root", config);
        instance = this;
    }

    override function preload():Void {
        untyped whiplash.Lib.phaserGame.device.audio.wav = true; // :HACK: Phaser wav detection is broken on iOS14
        super.preload();
        var scene = whiplash.Lib.phaserScene;
        Factory.preload(scene);
    }

    override function create():Void {
        super.create();

        var scene = whiplash.Lib.phaserScene;
        Factory.load(scene);

        var game = whiplash.Lib.phaserGame;
        game.sound.pauseOnBlur = false;

        whiplash.Input.setup(new JQuery(".root")[0]);

        var engine = whiplash.Lib.ashEngine;

        engine.addSystem(new ObjectSystem(), 1);
    }

    override function start() {
        var engine = whiplash.Lib.ashEngine;
        var e = Factory.createBackground();
        e.get(Transform).position.setTo(Config.screen.width / 2, Config.screen.height / 2);
        engine.addEntity(e);
        var e = Factory.createPlanet();
        e.get(Transform).position.setTo(Config.screen.width / 2, Config.screen.height / 2);
        engine.addEntity(e);
        var e = Factory.createRocket();
        e.get(Transform).position.setTo(400, 100);
        e.get(Object).velocity.setTo(200,-200);
        engine.addEntity(e);
    }
}
