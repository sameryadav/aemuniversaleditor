# Alternative Content Fragment Overlay Setup

## Issue with json2html Service

**Problem**: The `https://json2html.adobeaem.workers.dev/` service appears to be unavailable or not publicly accessible.

**Evidence**:
- All endpoints return "404, not found!"
- Base service URL returns 404
- Valid Adobe IMS token works fine with other Adobe services

## Alternative Approach: Direct AEM Overlay

Since the external json2html service isn't working, let's configure a direct AEM-based overlay:

### Step 1: Update fstab.yaml for Direct Overlay

```yaml
mountpoints:
  /:
    url: "https://author-p8661-e624335.adobeaemcloud.com/bin/franklin.delivery/sameryadav/aemuniversaleditor/main"
    type: "markup"
    suffix: ".html"
  /press/:
    url: "https://author-p8661-e624335.adobeaemcloud.com/api/assets/aemuniversaleditor/press"
    type: "json"
    suffix: ".json"
```

### Step 2: Create Content Fragment Block

Create a custom block to handle content fragment rendering:

1. **Create block directory**: `blocks/contentfragment/`
2. **Add JavaScript**: Process JSON and render HTML
3. **Add CSS**: Style the output
4. **Add configuration**: Define field mappings

### Step 3: Alternative fstab.yaml Configuration

```yaml
mountpoints:
  /:
    url: "https://author-p8661-e624335.adobeaemcloud.com/bin/franklin.delivery/sameryadav/aemuniversaleditor/main"
    type: "markup" 
    suffix: ".html"
    overlay:
      url: "https://your-custom-overlay-service.com/sameryadav/aemuniversaleditor/main"
      type: "markup"
```

## Recommended Immediate Actions

### 1. Contact Adobe Support
- **Ask about**: json2html service availability
- **Request**: Proper service URL or alternative configuration
- **Mention**: You're trying to set up content fragment overlays for Edge Delivery Services

### 2. Create Regular AEM Page (Quick Win)
While resolving the overlay issue:
1. Go to AEM Sites Console
2. Create `/content/aemuniversaleditor/press` page
3. Publish it
4. Test: `https://main--aemuniversaleditor--sameryadav.aem.page/press.html`

### 3. Verify Content Fragment Setup
1. Ensure content fragments exist in: `/content/dam/aemuniversaleditor/press/`
2. Confirm they are published
3. Test direct access: `https://author-p8661-e624335.adobeaemcloud.com/content/dam/aemuniversaleditor/press/press1`

## Custom Overlay Implementation

If Adobe Support confirms the service isn't available, we can implement a custom solution:

### Option A: Client-Side Rendering
```javascript
// blocks/contentfragment/contentfragment.js
export default async function decorate(block) {
  const fragmentId = block.textContent.trim();
  const response = await fetch(`/api/fragments/${fragmentId}.json`);
  const data = await response.json();
  
  // Render using template
  block.innerHTML = renderTemplate(data);
}
```

### Option B: Build-Time Processing
- Use GitHub Actions to process content fragments
- Generate static HTML during build
- Deploy to Edge Delivery Services

### Option C: Helix Pipeline Extension
- Create custom pipeline step
- Process content fragments during page generation
- Transform JSON to HTML server-side

## Next Steps

1. **✅ Contact Adobe Support** - Get clarification on json2html service
2. **✅ Create regular press page** - Get immediate functionality  
3. **✅ Verify content fragment location** - Ensure fragments exist and are published
4. **⏳ Implement alternative** - Based on Adobe's response

## Contact Information for Adobe Support

**What to ask**:
- "Is the json2html.adobeaem.workers.dev service available for my organization?"
- "What's the correct way to configure content fragment overlays for Edge Delivery Services?"
- "Are there alternative methods for transforming content fragments to HTML?"

**Include**:
- Your Adobe Org ID: `FD6415F354EEF3250A4C98A4@AdobeOrg`
- Your client credentials (not the secrets, just the client ID)
- The specific error you're encountering

## Expected Outcome

With Adobe's guidance, you should be able to:
1. Get the correct service URL or alternative method
2. Successfully configure content fragment overlays
3. Access content fragments via: `/press/fragment-name` URLs
