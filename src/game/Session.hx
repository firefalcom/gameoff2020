package game;

import ash.core.Entity;

class Session {
    public var levelIndex:Int;
    public var attempts:Int = 0;
    public var time:Float = 0;
    public var paused:Bool = false;

    public var stars:Array<Entity> = [];

    public function new(levelIndex) {
        this.levelIndex = levelIndex;
    }
}
