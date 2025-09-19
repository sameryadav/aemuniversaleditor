# Content Fragment Templates

This directory contains Mustache templates for transforming AEM Content Fragments into semantic HTML for Edge Delivery Services.

## Templates

### press.html
Template for press release content fragments. Maps common content fragment fields to semantic HTML structure.

#### Supported Fields
- `title` - Main headline
- `summary` - Brief description/summary
- `content` - Main article content (HTML)
- `text` - Additional text content (HTML)
- `author` - Author name
- `publishDate` - Publication date
- `image` - Featured image object with src, alt, width, height
- `gallery` - Array of image objects
- `tags` - Array of tag strings
- `category` - Content category
- `relatedLinks` - Array of link objects with url and title
- `contactName` - Press contact name
- `contactEmail` - Press contact email
- `contactPhone` - Press contact phone
- `location` - Event/news location
- `source` - Content source

#### Usage
The template uses Mustache syntax:
- `{{property}}` - Simple text substitution
- `{{{property}}}` - HTML content (unescaped)
- `{{#property}}...{{/property}}` - Conditional blocks
- `{{#array}}...{{/array}}` - Loop over arrays

#### Customization
Modify the template to match your content fragment model structure and desired HTML output. Ensure all asset paths use absolute URLs or the `relativeURLPrefix` configuration.
