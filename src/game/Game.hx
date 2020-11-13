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

    public function new() {
        super(Config.gameWidth, Config.gameHeight, ".root", phaser.scale.scalemodes.NONE);
        instance = this;
    }

    override function preload():Void {
        untyped whiplash.Lib.phaserGame.device.audio.wav = true; // :HACK: Phaser wav detection is broken on iOS14
        super.preload();
        var scene = whiplash.Lib.phaserScene;
        Factory.preload(scene);
        scene.load.on('progress', onLoadProgress);
        scene.load.start();
    }

    override function create():Void {
        var scene = whiplash.Lib.phaserScene;
        Factory.load(scene);
        var game = whiplash.Lib.phaserGame;
        game.sound.pauseOnBlur = false;
        whiplash.Input.setup(new JQuery(".root")[0]);
        AudioManager.init(whiplash.Lib.phaserScene);
    }

    override function onGuiLoaded() {
    }

    private function onLoadProgress(progress) {
    }

    static function main():Void {
        new Game();
    }
}
