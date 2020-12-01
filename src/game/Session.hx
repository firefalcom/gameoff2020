package game;

import ash.core.Entity;

class Session {
    public var levelIndex:Int;
    public var attempts:Int = 0;
    public var time:Float = 0;
    public var paused:Bool = false;

    public var stars:Array<Entity> = [];
    public var starsCollected:Int;

    public var dead = false;

    public function new(levelIndex) {
        this.levelIndex = levelIndex;
    }

    public function reset() {
        starsCollected = 0;
        dead = false;
    }
}
