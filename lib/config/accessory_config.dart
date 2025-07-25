class AccessoryFit {
  final double widthFactor;

  final double heightFactor;

  final double topOffsetFactor;

  final double horizontalOffsetFactor;

  const AccessoryFit({
    this.widthFactor = 1.0,
    this.heightFactor = 1.0,
    this.topOffsetFactor = 0.0,
    this.horizontalOffsetFactor = 0.0,
  });
}

const Map<String, AccessoryFit> accessoryFits = {
  'assets/images/formal-shirt.png': AccessoryFit(
    widthFactor: 0.69,
    heightFactor: 0.64,
    topOffsetFactor: 0.40,
    horizontalOffsetFactor: 0.0,
  ),

  'assets/images/cool-glasses.png': AccessoryFit(
    widthFactor: 0.5,
    heightFactor: 0.5,
    topOffsetFactor: 0.1,
    horizontalOffsetFactor: 0.0,
  ),

  'assets/images/hat.png': AccessoryFit(
    widthFactor: 0.8,
    heightFactor: 1.2,
    topOffsetFactor: -0.45,
    horizontalOffsetFactor: 0.0,
  ),
  'assets/images/hat-2.png': AccessoryFit(
    widthFactor: 0.7,
    heightFactor: 1.4,
    topOffsetFactor: -0.5,
    horizontalOffsetFactor: 0.0,
  ),
  'assets/images/hat-3.png': AccessoryFit(
    widthFactor: 0.8,
    heightFactor: 1.3,
    topOffsetFactor: -0.4,
    horizontalOffsetFactor: -0.01,
  ),
  'assets/images/hat-4.png': AccessoryFit(
    widthFactor: 0.9,
    heightFactor: 1.3,
    topOffsetFactor: -0.48,
    horizontalOffsetFactor: 0.0,
  ),
  'assets/images/hat-5.png': AccessoryFit(
    widthFactor: 0.7,
    heightFactor: 1.4,
    topOffsetFactor: -0.5,
    horizontalOffsetFactor: 0.0,
  ),
  'assets/images/hat-6.png': AccessoryFit(
    widthFactor: 0.75,
    heightFactor: 1.1,
    topOffsetFactor: -0.42,
    horizontalOffsetFactor: 0.0,
  ),
  'assets/images/pirate-hat.png': AccessoryFit(
    widthFactor: 1,
    heightFactor: 1.5,
    topOffsetFactor: -0.55,
    horizontalOffsetFactor: 0.0,
  ),
};
