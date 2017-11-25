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

Transform | Usage via Webservice | Local Usage | Supported
---------|--------|---------|------------
Identity | `Identity` | `identity` | Y
Translate | `Translate 5 5` | `translate 5 5` | Y
Scale | `Scale 5 5` | `scale 5 5` | Y
Rotate | `Rotate 30` | `rotate 30` | Y
Compose | `Compose (Rotate 30) (Scale 5 5)` | `rotate 30 <+> scale 5 5` | Y

### Supported VisTransforms

VisTransform | Usage via Webservice | Local Usage | Supported
-------------|-------|---------|-------------
Fill | `Fill Red` | `fill red` | Y
StrokeWidth | `StrokeWidth 7.5` | `strokeWidth 7.5` | Y
Stroke | `Stroke Blue` | `stroke blue` | Y
Opacity | `Opacity 0.5` | `opacity 0.5` | Y
ComposeVis | `ComposeVis (Fill Red) (Opacity 0.25)` | `fill red <!> opacity 0.25` | Y

### Supported Shapes

Shape | Usage via Webservice | Local Usage | Supported
------|--------|------|-----
Circle | `Circle` | `circle` | Y
Square | `Square` | `square` | Y
Rectangle | `Rect` | `rect` | Y
Ellipse | `Ellipse` | `ellipse` | Y

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
* Input is converted from Text to a String, and interpreted into a `Just Drawing` or `Nothing`.
	* This is interpretation is done using the `readMaybe` function from Text.
* Assuming the description is valid and the interpreter function returns `Just Drawing`, the `Drawing` is passed to the `SvgBuilder`.
* The `SvgBuilder` declares a generic Svg header, and the maps the `renderShape` function across each `Renderable` in the `Drawing`.
* `renderShape` simply pattern matches out the `Transform`, `VisTransform`, and `Shape` used to describe the Svg.

# DSL Design

My goal in designing the DSL was to ensure that its functionality was met with simplicity. To achieve this simplicity, I went for a modular structure:

* **The Main Module** simply uses Scotty to serve a simple html form, when the form is executed the contents of the input field is interpreted into a `Maybe Drawing` description. If the Drawing is valid, an Svg is built, if it is invalid, an error message is displayed.

* **The Shapes Module** consists of simple shape definitions, as well as the type declarations of Renderable and Drawing.

* **The Colors Module** just provides constructors for Colors. *Probably unnecessary ones at that.*

* **The Transformations Module** consists of the two types of transform, and the simple functions needed to actually execute them.

* **The VisualHandler Module** is used to handle the possible visual transforms and make them available to the render functions. I built this module due to difficulties encountered in composing the VisTransforms as the Blaze Svg style combinators returned Attributes as opposed to AttributeValues.

* **The SvgHandler Module** builds the Svgs described by the received Drawings. To allow for combined Visual Transforms on the Svgs that it renders, the SvgHandler's render function applies the Visual Transformations to a default VisualHandler and uses the values that remain in its rendering.

## Design Tradeoffs

My initial plan for the DSL was to have my Main module, along with Shapes, Colors, Transformations, and an SvgHandler, however I had to implement the VisualHandler to facilitate the composition of visual transformations.

Transformations such as `translate` or `scale`, as provided by Blaze Svg, take their parameters and return an AttributeValue, which is then wrapped into the `transform` Attribute. This makes it easy to compose these transforms, as the AttributeValues can be combined into a single attribute.

Visual Transforms however are represented by individual Attributes, so this form of composition is not possible. This was the motivation behind creating a module which would provide a type to absorb these transformations onto a default set of attributes, and render the result.
