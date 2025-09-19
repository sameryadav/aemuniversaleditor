# Content Fragment Debug Guide

## Current Status
- ❌ Content fragment `press1` not accessible on publish instance (404)
- ❌ json2html service authentication failing
- ❌ Overlay not working

## Step-by-Step Debug Process

### Step 1: Verify Content Fragment Exists

**In AEM Assets Console** (`https://author-p8661-e624335.adobeaemcloud.com/assets.html`):

1. **Check these locations**:
   - `/content/dam/aemuniversaleditor/press/press1`
   - `/content/dam/press/press1`
   - `/content/dam/aemuniversaleditor/press1`

2. **Verify content fragment details**:
   - Does the fragment exist?
   - What's the exact path?
   - Is it marked as "Published" (green badge)?

### Step 2: Check Publication Status

**If fragment exists but not published**:
1. Select the content fragment
2. Click "Quick Publish" 
3. Wait for publication to complete
4. Verify green "Published" badge appears

### Step 3: Verify Content Fragment Model

**Check if Content Fragment Model exists**:
1. Go to: `/conf/aemuniversaleditor/settings/dam/cfm/models`
2. Ensure model is created and published
3. Verify model has required fields (title, content, etc.)

### Step 4: Test Different Paths

**Update paths.json if fragment is in different location**:

Current: `/content/dam/aemuniversaleditor/press/:/press/`

Try these alternatives if needed:
```json
{
  "mappings": [
    "/content/aemuniversaleditor/:/",
    "/content/aemuniversaleditor/configuration:/.helix/config.json",
    "/content/aemuniversaleditor/metadata:/metadata.json",
    "/content/dam/press/:/press/"
  ]
}
```

### Step 5: Alternative json2html Service Setup

**Try different authentication approach**:

1. **Check if admin-api-token is different**:
   - The service might need a specific type of token
   - Contact Adobe support for correct token type

2. **Test with no authentication**:
   - Some services might work without auth initially
   - Try accessing config endpoint directly

### Step 6: Manual Testing

**Test fragment accessibility**:

```bash
# Test with authentication (you'll need to login)
# Go to browser and access:
https://author-p8661-e624335.adobeaemcloud.com/content/dam/aemuniversaleditor/press/press1

# Check if JSON is available:
https://publish-p8661-e624335.adobeaemcloud.com/content/dam/aemuniversaleditor/press/press1.json
```

## Most Likely Issues (in order of probability)

### 1. Content Fragment Not Published (90%)
- **Solution**: Publish the content fragment in AEM
- **Test**: Check for green "Published" badge

### 2. Content Fragment in Wrong Location (70%)
- **Solution**: Find actual location and update paths.json
- **Test**: Search in AEM Assets console

### 3. Content Fragment Model Missing (50%)
- **Solution**: Create/publish the model first
- **Test**: Check `/conf/aemuniversaleditor/settings/dam/cfm/models`

### 4. json2html Service Authentication (60%)
- **Solution**: Get correct admin token or contact support
- **Test**: Try alternative overlay methods

## Quick Wins

### Win 1: Create Regular Page
Create `/content/aemuniversaleditor/press` page → Immediate `/press.html` access

### Win 2: Find Content Fragment
Search AEM Assets for actual location of `press1`

### Win 3: Direct JSON Test
Test if fragment JSON is accessible after publishing

## Success Criteria

### Phase 1: Basic Page Working
- ✅ `/press.html` returns 200 (regular AEM page)

### Phase 2: Content Fragment Found
- ✅ Fragment exists and is published
- ✅ JSON accessible on publish instance

### Phase 3: Overlay Working
- ✅ json2html service configured
- ✅ `/press/press1` returns HTML (not 404)

## Next Actions

1. **Immediate**: Create regular AEM page for `/press.html`
2. **Debug**: Find exact location of content fragment
3. **Publish**: Ensure fragment is published
4. **Test**: Verify JSON accessibility
5. **Fix**: Resolve json2html authentication

## Expected Timeline

- **5 minutes**: Regular page working
- **15 minutes**: Content fragment located and published
- **30 minutes**: Overlay working (depends on service auth)
