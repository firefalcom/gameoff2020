package game.display;

class Glow {
    public var time:Float = 0.0;
    public var speed:Float;

    public var countLeft:Int;

    public function new(countLeft, speed) {
        this.countLeft = countLeft;
        this.speed = speed;
    }
}
