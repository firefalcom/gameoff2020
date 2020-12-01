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

    public var session:Session;

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
        window.addEventListener("resize", resize);
    }

    override function initPages() {
        pages = js.uipages.Lib.createGroup(new JQuery(".pages"), "fade", "fade");
        pages.showPage(".default");
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

        engine.addSystem(new game.logic.AttachSystem(), 2);

        var mainMenuState = createState("mainMenu");
        mainMenuState.addInstance(new game.logic.MainMenuSystem());

        var levelMenuState = createState("levelMenu");
        levelMenuState.addInstance(new game.logic.LevelMenuSystem());

        var levelLoadingState = createState("levelLoading");
        levelLoadingState.addInstance(new game.logic.LevelLoadingSystem()).withPriority(0);

        var ingameState = createState("ingame");
        ingameState.addInstance(new game.logic.HudSystem()).withPriority(0);

        ingameState.addInstance(new game.logic.ObjectSystem()).withPriority(2);

        ingameState.addInstance(new game.display.RocketSystem()).withPriority(1);
        ingameState.addInstance(new game.display.GlowSystem()).withPriority(1);
        // ingameState.addInstance(new game.display.CameraSystem()).withPriority(3);

        var preparingState = createIngameState("preparing");
        preparingState.addInstance(new game.logic.PrepareSystem()).withPriority(1);

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
        resize();
        changeState("mainMenu");
        whiplash.AudioManager.playMusic("moonlander_theme_loop-warp", 0.2);
        new js.jquery.JQuery(".button").click((e) -> {
            whiplash.AudioManager.playSound("fx_ui_select_02", 0.5);
        });
        new js.jquery.JQuery(".button").mouseover((e) -> {
            whiplash.AudioManager.playSound("fx_ui_select_01", 0.5);
        });
    }

    public function startGame(levelIndex:Int = 0) {
        session = new Session(levelIndex);
        engine.removeAllEntities();
        changeState("levelLoading");
    }

    public function setupCamera() {
        var e = engine.getEntityByName("camera");

        if(e != null) {
            e.get(Transform).position.setTo(
                - Config.screen.width / 2,
                - Config.screen.height / 2
            );
        }
    }

    public function getMouseWorldPosition():Vector2 {
        var mouseCoords = whiplash.Input.mouseCoordinates;
        var e = engine.getEntityByName("camera");

        if(e != null) {
            e.get(whiplash.phaser.Camera).getWorldPoint(mouseCoords.x, mouseCoords.y);
        }

        return new Vector2(0, 0);
    }

    private function resize() {
        var canvas:js.html.CanvasElement = whiplash.Lib.phaserGame.canvas;

        if(canvas == null) {
            return;
        }

        var width:Int = window.innerWidth;
        var height:Int = window.innerHeight;
        canvas.width = width;
        canvas.height = height;
        whiplash.Lib.phaserScene.cameras.resize(width, height);
        whiplash.Lib.phaserGame.scale.resize(width, height);
        Config.screen.width = width;
        Config.screen.height = height;
        setupCamera();
    }
}
