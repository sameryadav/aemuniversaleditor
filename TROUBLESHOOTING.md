# Troubleshooting Content Fragment Access

## 404 Error on `/press.html`

### Problem
Getting 404 when accessing `https://main--aemuniversaleditor--sameryadav.aem.page/press.html`

### Explanation
The configuration is set up for **individual content fragments**, not a general press page. Content fragments are accessed via their specific names, not as `.html` pages.

### Solutions

#### Option 1: Access Individual Content Fragments (Recommended)

**Step 1: Create a Content Fragment in AEM**
1. Go to AEM Assets: `https://author-p8661-e624335.adobeaemcloud.com/assets.html`
2. Navigate to `/content/dam/aemuniversaleditor/press/`
3. Create a new Content Fragment (e.g., "latest-news")
4. Fill in the content and **publish** it

**Step 2: Access the Fragment**
- URL pattern: `https://main--aemuniversaleditor--sameryadav.aem.page/press/{fragment-name}`
- Example: `https://main--aemuniversaleditor--sameryadav.aem.page/press/latest-news`

#### Option 2: Create a Press Landing Page

If you want a general `/press.html` page, create a regular AEM page:

**Step 1: Create Page in AEM**
1. Go to AEM Sites: `https://author-p8661-e624335.adobeaemcloud.com/sites.html`
2. Navigate to `/content/aemuniversaleditor/`
3. Create a new page called "press"
4. Add content and **publish** it

**Step 2: Access the Page**
- URL: `https://main--aemuniversaleditor--sameryadav.aem.page/press.html`

#### Option 3: Test with Sample Content Fragment

**Test Fragment Creation:**
```bash
# Test if your AEM instance is accessible
curl -I "https://author-p8661-e624335.adobeaemcloud.com/assets.html"

# Check if json2html service is configured
curl "https://json2html.adobeaem.workers.dev/config/sameryadav/aemuniversaleditor/main"
```

### Current Configuration Summary

**Your setup handles:**
- ✅ Individual content fragments: `/press/{fragment-name}`
- ✅ JSON to HTML transformation via Mustache template
- ✅ Overlay configuration for content fragments

**Your setup does NOT handle:**
- ❌ General landing pages like `/press.html`
- ❌ Directory listings of content fragments

### Verification Steps

1. **Check json2html Service Configuration:**
   ```bash
   curl https://json2html.adobeaem.workers.dev/config/sameryadav/aemuniversaleditor/main
   ```

2. **Test Content Fragment API:**
   ```bash
   curl "https://author-p8661-e624335.adobeaemcloud.com/api/assets/aemuniversaleditor/press/YOUR_FRAGMENT.json"
   ```

3. **Verify Edge Delivery Services:**
   - Check if your site loads: `https://main--aemuniversaleditor--sameryadav.aem.page/`
   - Test with existing content first

### Next Steps

1. **For Content Fragments:**
   - Create content fragments in `/content/dam/aemuniversaleditor/press/`
   - Access them via `/press/{fragment-name}` (no .html extension)

2. **For a Press Landing Page:**
   - Create a regular AEM page in `/content/aemuniversaleditor/press`
   - Access it via `/press.html`

3. **For Both:**
   - Create a press landing page that lists/links to individual content fragments
   - This gives you both a landing page and fragment detail pages

### Common Issues

- **Content not published**: Ensure content fragments are published in AEM
- **Cache issues**: Clear CDN/dispatcher cache after publishing
- **Authentication**: Some APIs may require authentication
- **Path case sensitivity**: URLs are case-sensitive

### Support

If issues persist:
1. Check AEM author instance accessibility
2. Verify content fragment model exists
3. Ensure publishing workflow is complete
4. Test with a simple content fragment first
