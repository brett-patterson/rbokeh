Version 0.4
----------------------------------------------------------------------

- fix issue with single-row input to `ly_bar()` (0.4.3)
- fix bug in rbokeh.js resize (0.4.2)
- rename save_figure to widget2png (0.4.2)
- rename widget2gist input name (0.4.2)
- add xlim/ylim args to grid_plot (0.4.2)
- rename rbokeh2gist to widget2gist (0.4.2)
- add bl.ocks.org yaml config options to `rbokeh2gist()` (0.4.2)
- honor backward specification of xlim/ylim (0.4.2)
- add `width` argument to `ly_boxplot` (0.4.1)
- update BokehJS to 0.11.1 (0.4.1)
- unname vectors to make jsonlite happy (0.4.1)
- fix bug in hover glyph for lines with mapped attrs (0.4.1)
- many fixes and streamlining of non-standard evaluation logic (0.4.1)
- add args argument to some callbacks (0.4.1)
- update hexbin to have xbnds, ybnds and allow `hover = FALSE` (0.4.1)
- add `visible` to list of valid opts for checking (0.4.0)
- fix issue with hiding legend when mapping attributes (0.4.0)
- propagate visible parameter to all glyphs (0.4.0)
- add hover glyph to have same properties as specified glyph with full opacity (0.4.0)
- fix issue with custom legend (0.4.0)
- add `visible` parameter to all glyphs (0.4.0)
- modularize `get_glyph_attrs()` so can be used for annotations (0.4.0)
- add selection callbacks (0.4.0)
- add annotation renderers to tools (0.4.0)
- change default tooltip colors (0.4.0)
- fix js callbacks to have unique ids (0.4.0)
- add hover callback example - thanks @saptarshiguha (0.4.0)
- refactor callback approach (0.4.0)
- add `get_object_refs()` method (0.4.0)
- fix bug in axis range introduced by range callback (0.4.0)
- fix layer naming defaults (0.4.0)
- add tool_tap with callback support (0.4.0)
- update `layer_ref` to callback tools (0.4.0)
- fix lname to be singleton (0.4.0)
- add callback examples (0.4.0)
- make callback work with specified layer names (0.4.0)
- add hover and tap callbacks (0.4.0)
- add range callback support (0.4.0)
- set default log level to 'info' with debug available through option (0.4.0)

Version 0.3
----------------------------------------------------------------------

- update `ly_hexbin()` to have `xbnds`, `ybnds` and allow `hover = FALSE` (0.3.5)
- change gist iframe to use rawgit because bl.ocks.org changed X-frame-options to SAMEORIGIN (0.3.4)
- add 'secure' option to `rbokeh2html()` for using https cdn links (0.3.4)
- add `desired_num_ticks` to axis options (0.3.4)
- fix issue with `ly_rect()` and datetime axes (0.3.4)
- set proper defaults in `gmap()` so that user can't do things they shouldn't (0.3.4)
- fix bug in `ly_image_url()` for computing w/h (0.3.4)
- update to Bokeh 0.11.0 (0.3.4)
- make POSIX detection more robust (0.3.3)
- fix bug in singleton glyphs involving date axis (0.3.3)
- fix margins for gridplots (0.3.3)
- fix bug in gridplot dimension calculation (0.3.3)
- fix bug in `ly_crect()` (0.3.2)
- fix ly_hist to allow a 'histogram' object (0.3.2)
- fix typo in ly_boxplot (0.3.1)
- fix json encoding issue when data is a list to begin with (0.3.1)
- fix single-row hover issue (0.3.1)
- fix abline to work with json encoding scheme (0.3.1)
- reduce verbosity (0.3.1)
- fill props if none for a glyph (0.3.1)
- fix custom date axis issue #100 (0.3.1)
- allow FALSE to hide legend (0.3.1)
- **major** overhaul of internal lazy evaluation logic to be more flexible
- add webgl parameter
- fix 2html and 2gist to handle NAs properly
- add `catjitter()` function for jittering categorical scales

Version 0.2.4
----------------------------------------------------------------------

- add `rbokeh2gist()`
- update to bokeh v0.10.0
- change `get_bokeh_html()` to `rbokeh2html()`
- modify `save_figure()` to use rbokeh2html instead of saveWidget
- fix small issues with `rbokeh2html()`
- allow null y for `ly_bar()`
- remove quotes that can appear in legend group headers
- fix issue with resolving character column names
- fix issue with single entry factorRange json encoding
- add initial barchart support
- fix JSON handling to make NAs render properly
- update to Bokeh v0.9.3
- initial support for themes
- move plot/axis/grid/legend themes to theme_ functions
- add headers to groups of legend entries from mapped attributes
- add help tool with redirect to rbokeh docs
- add grid parameter support for finer control over grid properties
- major overhaul of input handling to accommodate more data input modes and provide for more robust mapped attributes
- fix hover for `ly_polygons()`
- add support for custom hover
- add full control over legend attributes
- in `grid_plot()` use `simplify_axes` to automatically size things so panels are same size
- add automatic labels to a grid plot if given a named list
- add dynamic sizing (on the R side) BokehGridPlot
- fix custom date axis issue
- add experimental phantomjs static export function, `save_figure()`
- add `map_style` to `gmap()`
- update to Bokeh v0.9.1
- fix issue with hover data frame not being found
- fix issue JSON encoding with hover data frame with only one row
- fix an issue with `grid_plot` and `tool_events` not having unique id
- added support for axis tick formatting to `x_axis` and `y_axis`
- switched to `jsonlite` from `RJSONIO`
- updated the library to be `data.table` aware
- fix bugs in `ly_lines()` and `ly_points()` parameter passing when grouping
- documentation updates

Version 0.2.2
----------------------------------------------------------------------

- update sizing policy to deal with `renderBokeh()`
- rbokeh plots are now htmlwidgets from the start
- fix URL tool

Version 0.2.1
----------------------------------------------------------------------

- fix dimension calculation so that resulting div is exactly the dimensions specified
- update default padding and text sizes
- fix sizing so that plots and grid plots on are exact dimensions as specified (resize canvas elements to accommodate for things drawn in the margins)
- fix bug in generating unique id for each plot
- allow toolbar to be completely hidden
- update documentation for `figure()`
- add sizing policy in rbokeh.js
- add default nonselection glyph properties for box/lasso select
- add basic theme support
- add non-standard evaluation specification of parameters
- add aesthetic mapping
- add automatic generation of legends for aesthetic mappings
- add generic legend support
- hover tool support
- tap to open URL support
- add datetime axis
- add log axis
- add ly_hexbin
- add grid_plot with linked pan/zoom and brushing
- several "stats" layers - hist, density, quantile, boxplot, etc.
- add image_url
- axis labels
- tools control
- migrate to standard json model
- move to s3 methods + pipes for adding layers

Version 0.1
----------------------------------------------------------------------

- add `data` argument to several glyph functions
- add `elements` data set for plotting periodic table
- add checking for spefication of options that are not used
- fix handling of pch and associated options
- remove individual marker methods - all accessible through `points()`
- `hist` method to show example of higher-level stat plots using glyphs
- automatic calculation for continuous and categorical scales
- basic color theme for adding components to figures
- preliminary support for base R graphics:
  - `points()` including glyph mappings to R's `pch`
  - `lines()` including `line_dash` mappings to R's `lty`
- nearly all glyphs implemented (image\_rgba and image\_url remain)
- reference class implementation of a bokeh "figure"
