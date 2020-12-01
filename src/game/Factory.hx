package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {
    static var phaserScene:phaser.Scene;

    static public function preload(scene:phaser.Scene) {
        phaserScene = scene;
        scene.load.spritesheet('fire-sheet', '../data/textures/fire.png', { frameWidth: 128, frameHeight: 128 });
        scene.load.spritesheet('landing-sheet', '../data/textures/spritesheet_target_V01.png', { frameWidth: 256, frameHeight: 78 });
        scene.load.spritesheet('launching-sheet', '../data/textures/spritesheet_launcher_V01.png', { frameWidth: 256, frameHeight: 256 });
        scene.load.spritesheet('explosion-sheet', '../data/textures/spritesheet_explosion.webp', { frameWidth: 128, frameHeight: 128});
    }

    static public function load(scene:phaser.Scene) {
        scene.anims.create({
            key: 'fire',
            frames: [
            { key:'fire-sheet', frame: 0 },
            { key:'fire-sheet', frame: 1 },
            ],
            frameRate: 10,
            repeat: -1
        });
        scene.anims.create({
            key: 'landing',
            frames: [
            { key:'landing-sheet', frame: 0 },
            { key:'landing-sheet', frame: 0 },
            { key:'landing-sheet', frame: 0 },
            { key:'landing-sheet', frame: 0 },
            { key:'landing-sheet', frame: 1 },
            ],
            frameRate: 5,
            repeat: -1
        });
        scene.anims.create({
            key: 'launcher',
            frames: [
            { key:'launching-sheet', frame: 0 },
            { key:'launching-sheet', frame: 0 },
            { key:'launching-sheet', frame: 0 },
            { key:'launching-sheet', frame: 0 },
            { key:'launching-sheet', frame: 1 },
            ],
            frameRate: 5,
            repeat: -1
        });
        scene.anims.create({
            key: 'explosion',
            frames: [
            { key:'explosion-sheet', frame: 0 },
            { key:'explosion-sheet', frame: 1 },
            { key:'explosion-sheet', frame: 2 },
            { key:'explosion-sheet', frame: 3 },
            { key:'explosion-sheet', frame: 4 },
            { key:'explosion-sheet', frame: 5 },
            { key:'explosion-sheet', frame: 6 },
            { key:'explosion-sheet', frame: 7 },
            { key:'explosion-sheet', frame: 8 },
            { key:'explosion-sheet', frame: 9 },
            { key:'explosion-sheet', frame: 10 },
            { key:'explosion-sheet', frame: 11 }
            ],
            frameRate: 16,
            repeat: 0
        });
    }

    static public function createBackground() {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite("background"));
        e.get(Transform).scale.setTo(2, 2);
        return e;
    }

    static public function createPlanet(type, mass, radius)  {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite(type));
        e.add(new game.logic.Object(false, mass, radius));
        var s = (0.5/105) * radius;
        e.get(Transform).scale.setTo(s, s);
        return e;
    }

    static public function createRocket() {
        var e = new Entity();
        e.name = "rocket";
        e.add(new Transform());
        e.add(new Sprite("rocket"));
        e.add(new game.logic.Object(true, 5, 20));
        e.add(new game.logic.Rocket());
        e.add(new game.display.Rocket());
        e.add(new Container());
        e.get(Transform).scale.setTo(0.2, 0.2);
        e.get(game.display.Rocket).boostEntities = [
                    null,
                    createFlame(),
                    createBigFlame()
                ];

        for(b in e.get(game.display.Rocket).boostEntities) {
            if(b != null) {
                e.get(Container).addChild(b);
            }
        }

        return e;
    }

    static public function createBigFlame() {
        var e = new Entity();
        e.add(new Transform());
        e.get(Transform).position.setTo(0, 180);
        e.get(Transform).scale.setTo(4, 3);
        e.add(new Sprite("fire"));
        e.get(Sprite).anims.play("fire");
        e.get(Sprite).alpha = 0;
        return e;
    }

    static public function createFlame() {
        var e = new Entity();
        e.add(new Transform());
        e.get(Transform).position.setTo(0, 155);
        e.get(Transform).scale.setTo(2.5, 1);
        e.add(new Sprite("fire"));
        e.get(Sprite).anims.play("fire");
        e.get(Sprite).alpha = 0;
        return e;
    }

    static public function createLauncher() {
        var e = new Entity();
        e.name = "launcher";
        e.add(new Transform());
        e.get(Transform).scale.setTo(0.3, 0.3);
        e.add(new game.logic.Attach());
        e.add(new Sprite("launcherSheet"));
        e.get(Sprite).anims.play("launcher");
        return e;
    }

    static public function createLandingPlatform() {
        var e = new Entity();
        e.add(new game.logic.LandingPlatform());
        e.add(new Transform());
        e.get(Transform).scale.setTo(0.25, 0.25);
        e.add(new game.logic.Attach());
        e.add(new Sprite("landingSheet"));
        e.get(Sprite).anims.play("landing");
        return e;
    }

    static public function createCamera() {
        var e = new Entity();
        e.name = "camera";
        e.add(new Transform());
        e.add(new Camera(0, 0, Config.screen.width, Config.screen.height));
        return e;
    }

    static public function createStar()  {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite("star"));
        e.add(new game.logic.Object(false, 1, 24));
        e.get(game.logic.Object).solid = false;
        e.add(new game.logic.Star());
        e.add(new game.display.Glow(null, 1, 0.5));
        var s = 0.3;
        e.get(Transform).scale.setTo(s, s);
        return e;
    }
}

