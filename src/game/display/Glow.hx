package game.display;

class Glow {
    public var time:Float = 0.0;
    public var speed:Float;
    public var minAlpha:Float;

    public var countLeft:Int;

    public function new(countLeft, speed, minAlpha) {
        this.countLeft = countLeft;
        this.speed = speed;
        this.minAlpha = minAlpha;
    }
}
