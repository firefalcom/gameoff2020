package game;

import whiplash.*;
import ash.core.Entity;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;
import ash.core.Node;
import ashextension.*;
import whiplash.*;
import js.jquery.*;
import whiplash.phaser.*;
import whiplash.math.*;
import js.Browser.window;
import js.Browser.document;

class Game extends Application {
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

        super(Config.gameWidth, Config.gameHeight, ".root", config);
        instance = this;
    }

    override function preload():Void {
        untyped whiplash.Lib.phaserGame.device.audio.wav = true; // :HACK: Phaser wav detection is broken on iOS14
        super.preload();
        var scene = whiplash.Lib.phaserScene;
        Factory.preload(scene);
    }

    override function create():Void {
        var scene = whiplash.Lib.phaserScene;
        Factory.load(scene);
        var game = whiplash.Lib.phaserGame;
        game.sound.pauseOnBlur = false;
        whiplash.Input.setup(new JQuery(".root")[0]);
        AudioManager.init(whiplash.Lib.phaserScene);

        initGame();
    }

    override function onGuiLoaded() {
    }

    private function initGame() {
        var engine = whiplash.Lib.ashEngine;
        var e = Factory.createBackground();
        engine.addEntity(e);
    }
}
