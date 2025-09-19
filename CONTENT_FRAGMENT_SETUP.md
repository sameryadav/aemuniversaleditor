# AEM Content Fragments to Edge Delivery Services Setup

This document describes the setup for publishing AEM Content Fragments to Edge Delivery Services using the content fragment overlay functionality.

## Overview

This setup enables publishing AEM Content Fragments as self-contained semantic HTML pages to Edge Delivery Services, improving omnichannel delivery and SEO optimization.

## Prerequisites

- AEM as a Cloud Service (AEMaaCS) environment
- Edge Delivery Services site using aem-boilerplate template
- Repoless setup enabled in Edge Delivery Services
- Content Fragments enabled for your site
- Admin API token for configuration service

## Configuration Steps

### Step 1: Path Mapping and Overlay Configuration ✅

The following files have been configured:

#### `fstab.yaml`
```yaml
mountpoints:
  /:
    url: "https://author-p8661-e624335.adobeaemcloud.com/bin/franklin.delivery/sameryadav/aemuniversaleditor/main"
    type: "markup"
    suffix: ".html"
    overlay:
      url: "https://json2html.adobeaem.workers.dev/sameryadav/aemuniversaleditor/main"
      type: "markup"
```

#### `paths.json`
```json
{
  "mappings": [
    "/content/aemuniversaleditor/:/",
    "/content/aemuniversaleditor/configuration:/.helix/config.json",
    "/content/aemuniversaleditor/metadata:/metadata.json",
    "/content/dam/aemuniversaleditor/press/:/press/"
  ],
  "includes": [
    "/content/aemuniversaleditor/",
    "/content/dam/aemuniversaleditor/"
  ]
}
```

### Step 2: json2html Service Configuration ✅

A configuration script has been created at `scripts/configure-json2html.sh`.

#### Usage:
```bash
# Set your admin API token
export ADMIN_API_TOKEN="your-admin-api-token-here"

# Optional: Set custom AEM instances (defaults are used from fstab.yaml)
export AEM_AUTHOR_INSTANCE="https://author-p8661-e624335.adobeaemcloud.com"
export AEM_PUBLISH_INSTANCE="https://publish-p8661-e624335.adobeaemcloud.com"

# Run the configuration script
./scripts/configure-json2html.sh
```

#### Manual Configuration (Alternative):
If you prefer manual configuration, use this curl command:

```bash
curl --request POST \
  --url https://json2html.adobeaem.workers.dev/config/sameryadav/aemuniversaleditor/main \
  --header 'Authorization: token YOUR_ADMIN_API_TOKEN' \
  --header 'Content-Type: application/json' \
  --data '[
    {
      "path": "/press/",
      "endpoint": "https://author-p8661-e624335.adobeaemcloud.com/api/assets/aemuniversaleditor/press/{{id}}.json",
      "regex": "/[^/]+$/",
      "template": "/cf-templates/press.html",
      "relativeURLPrefix": "https://publish-p8661-e624335.adobeaemcloud.com",
      "headers": {
        "Accept": "application/json"
      },
      "forwardHeaders": [
        "Authorization"
      ]
    }
  ]'
```

### Step 3: Mustache Template ✅

A Mustache template has been created at `cf-templates/press.html` for transforming content fragment JSON into semantic HTML.

#### Supported Content Fragment Fields:
- `title` - Main headline
- `summary` - Brief description/summary  
- `content` - Main article content (HTML)
- `text` - Additional text content (HTML)
- `author` - Author name
- `publishDate` - Publication date
- `image` - Featured image object
- `gallery` - Array of image objects
- `tags` - Array of tag strings
- `category` - Content category
- `relatedLinks` - Array of link objects
- `contactName`, `contactEmail`, `contactPhone` - Press contact info
- `location` - Event/news location
- `source` - Content source

## Testing Your Setup

1. **Create a Content Fragment Model** in AEM with the fields supported by the template
2. **Create a Content Fragment** using the model
3. **Publish the Content Fragment** to Edge Delivery Services
4. **Access the published content** at: `https://your-site.com/press/content-fragment-name`

## Verification

- Verify json2html configuration: `https://json2html.adobeaem.workers.dev/config/sameryadav/aemuniversaleditor/main`
- Check that content fragments are accessible via the `/press/` path
- Ensure semantic HTML is properly generated

## Troubleshooting

### Common Issues:

1. **404 Errors**: Check path mappings in `paths.json` and `fstab.yaml`
2. **Template Errors**: Verify Mustache syntax in `cf-templates/press.html`
3. **Authentication Issues**: Ensure admin API token is correct and has proper permissions
4. **Asset Path Issues**: Check `relativeURLPrefix` configuration

### Debug Steps:

1. Test the API endpoint directly: `https://author-p8661-e624335.adobeaemcloud.com/api/assets/aemuniversaleditor/press/FRAGMENT_ID.json`
2. Check json2html service logs
3. Verify content fragment is published in AEM
4. Test template rendering with sample data

## Customization

### Adding More Content Types:

1. Create additional path mappings in `paths.json`
2. Add corresponding configuration to json2html service
3. Create new Mustache templates in `cf-templates/`

### Modifying the Template:

Edit `cf-templates/press.html` to match your content fragment model structure. Use Mustache syntax for dynamic content rendering.

## Support

For issues with this setup:
1. Check AEM and Edge Delivery Services documentation
2. Verify all configuration files are properly formatted
3. Test each component individually
4. Contact your AEM administrator for access-related issues
