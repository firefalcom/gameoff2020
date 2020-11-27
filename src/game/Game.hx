package game;

import ash.core.Entity;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;
import ash.core.Node;
import js.jquery.*;
import whiplash.math.*;
import whiplash.phaser.Transform;
import js.Browser.window;
import js.Browser.document;

class Game extends whiplash.Application {
    static public var instance:Game;

    private var camera:whiplash.phaser.Camera;

    static function main():Void {
        new Game();
    }

    public function new() {
        var config = {
            render:{
                transparent: true
            },
            scale : {
                mode: phaser.scale.scalemodes.NONE
            },
            // backgroundColor:"#000000"
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
        whiplash.Lib.phaserGame.scale.stopListeners();
        var scene = whiplash.Lib.phaserScene;
        Factory.load(scene);

        var game = whiplash.Lib.phaserGame;
        game.sound.pauseOnBlur = false;

        whiplash.Input.setup(new JQuery(".root")[0]);

        var engine = whiplash.Lib.ashEngine;

        var mainMenuState = createState("mainMenu");
        mainMenuState.addInstance(new game.logic.MainMenuSystem());

        var levelMenuState = createState("levelMenu");
        levelMenuState.addInstance(new game.logic.LevelMenuSystem());

        var ingameState = createState("ingame");

        ingameState.addInstance(new game.logic.ObjectSystem()).withPriority(2);
        ingameState.addInstance(new game.logic.AttachSystem()).withPriority(2);

        ingameState.addInstance(new game.display.RocketSystem()).withPriority(1);
        ingameState.addInstance(new game.display.GlowSystem()).withPriority(1);
        // ingameState.addInstance(new game.display.CameraSystem()).withPriority(3);

        var preparingState = createIngameState("preparing");
        preparingState.addInstance(new game.logic.PrepareSystem());

        var launchingState = createIngameState("launching");
        launchingState.addInstance(new game.logic.LaunchSystem());

        var navigatingState = createIngameState("navigating");
        navigatingState.addInstance(new game.logic.RocketSystem()).withPriority(1);
        navigatingState.addInstance(new game.logic.LandingPlatformSystem()).withPriority(2);

        var landingState = createIngameState("landing");
        landingState.addInstance(new game.logic.LandingSystem()).withPriority(3);

        var winningState = createIngameState("winning");
        winningState.addInstance(new game.logic.WinningSystem());

        var failingState = createIngameState("failing");
        failingState.addInstance(new game.logic.FailingSystem());


        {
            createUiState("hud", ".hud");
            createUiState("win", ".win");
            createUiState("mainMenu", ".mainMenu");
            createUiState("levelMenu", ".levelMenu");
        }

        super.create();

    }

    override function start() {
        changeState("mainMenu");
    }

    public function startGame() {
        engine.removeAllEntities();
        var engine = whiplash.Lib.ashEngine;
        var e = Factory.createCamera();
        camera = e.get(whiplash.phaser.Camera);
        engine.addEntity(e);
        {
            var e = Factory.createEarth();
            e.get(Transform).position.setTo(300, 300);
            engine.addEntity(e);
            var p = Factory.createLauncher();
            p.get(game.logic.Attach).planet = e;
            p.get(game.logic.Attach).offset = 30;
            p.get(game.logic.Attach).angle = 25;
            engine.addEntity(p);
            var e = Factory.createExotic();
            e.get(Transform).position.setTo(1300, 200);
            engine.addEntity(e);
            var e = Factory.createMoon();
            e.get(Transform).position.setTo(900, 400);
            engine.addEntity(e);
            var p = Factory.createLandingPlatform();
            p.get(game.logic.Attach).planet = e;
            p.get(game.logic.Attach).angle = -45;
            engine.addEntity(p);
        }
        changeState("ingame");
        changeIngameState("preparing");
        // changeIngameState("winning");
    }

    public function getMouseWorldPosition():Vector2 {
        var mouseCoords = whiplash.Input.mouseCoordinates;
        return camera.getWorldPoint(mouseCoords.x, mouseCoords.y);
    }
}
