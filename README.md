# Shape Server in Haskell

### SVG rendering server for CS4012

The server takes in descriptions of **Drawings**, which are lists of **Renderables**, and returns an Svg based on the description.

Each **Renderable** is a tuple of three items
1. Transforms
	* Transforms describe coordinate based manipulations of the Svg.
2. VisTransforms
	* VisTransforms describe visual/stylistic manipulations of the Svg.
3. Shape
	* Shapes describe the actual shape displayed by the Svg.

Transform | Usage | Supported
------------------------------
Identity | `Identity` | [ ]
Translate | `Translate 5 5` | [x]
Scale | `Scale 5 5` | [x]
Rotate | `Rotate 30` | [x]
Compose | `Compose (Rotate 30) (Scale 5 5)` | [x]

