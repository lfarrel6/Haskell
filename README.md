# Shape Server in Haskell

### SVG rendering server for CS4012

The server utilises a DSL to take in descriptions of **Drawings**, which are lists of **Renderables**, and return an Svg based on the description.

Each **Renderable** is a tuple of three items
1. Transforms
	* Transforms describe coordinate based manipulations of the Svg.
2. VisTransforms
	* VisTransforms describe visual/stylistic manipulations of the Svg.
3. Shape
	* Shapes describe the actual shape displayed by the Svg.

### Supported Transforms

Transform | Usage | Supported
---------|--------|-----------
Identity | `Identity` | N
Translate | `Translate 5 5` | Y
Scale | `Scale 5 5` | Y
Rotate | `Rotate 30` | Y
Compose | `Compose (Rotate 30) (Scale 5 5)` | Y

### Supported VisTransforms

VisTransform | Usage | Supported
-------------|-------|-----------
Fill | `Fill Red` | Y
StrokeWidth | `StrokeWidth 7.5` | Y
Stroke | `Stroke Blue` | Y
Opacity | `Opacity 0.5` | Y
ComposeVis | `ComposeVis (Fill Red) (Opacity 0.25)` | N

### Supported Shapes

Shape | Usage | Supported
------|-----|-----
Circle | `Circle` | Y
Square | `Square` | Y
Rectangle | `Rect` | Y

### Supported Colours
* White
* Black
* Red
* Blue
* Green
* Aqua
* Firebrick
* Goldenrod

# Flow

* Input is provided through the text box on the first page.
* Input is converted from Text to a String, and interpreted into `Just` a description of a Drawing or `Nothing`.
	* This is interpretation is done using the `readMaybe` function from Text.
* Assuming the description is valid and the interpreter function returns `Just` a `Drawing`, the `Drawing` is passed to the `SvgBuilder`.
* The `SvgBuilder` declares a generic Svg header, and the maps the `renderShape` function across each `Renderable` in the `Drawing`.
* `renderShape` simply pattern matches out the `Transform`, `VisTransform`, and `Shape` used to describe the Svg.
