package game;

class Session {
    public var levelIndex:Int;
    public var attempts:Int = 0;
    public var time:Float = 0;

    public function new(levelIndex) {
        this.levelIndex = levelIndex;
    }
}
