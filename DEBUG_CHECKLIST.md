# Debug Checklist for Content Fragment 404 Error

## Current Status
- ✅ EDS Site Working: `https://main--aemuniversaleditor--sameryadav.aem.page/`
- ❌ Content Fragment API: 401 Unauthorized
- ❌ json2html Service: Unauthorized
- ❌ Fragment URL: 404 Error

## Critical Issues to Check

### 1. Content Fragment Location ⚠️
**Problem**: API endpoint returns 401 Unauthorized

**Check in AEM**:
- Go to: `https://author-p8661-e624335.adobeaemcloud.com/assets.html`
- Navigate to: `/content/dam/aemuniversaleditor/press/`
- Verify `press1` content fragment exists at this exact location
- Check if the folder structure exists

**Alternative Locations to Check**:
- `/content/dam/press/` (without aemuniversaleditor prefix)
- `/content/dam/aemuniversaleditor/` (root level)
- Any other location where you might have created it

### 2. Content Fragment Publishing Status ⚠️
**Critical**: Content fragment MUST be published to be accessible

**In AEM**:
1. Select the `press1` content fragment
2. Check the status (should show "Published" green icon)
3. If not published, click "Quick Publish"
4. Wait for publication to complete

### 3. Content Fragment Model ⚠️
**Check**:
- Does a Content Fragment Model exist?
- Is the model published?
- Are the field names matching your template?

### 4. Cloud Configuration Assignment ⚠️
**In AEM DAM Folder Properties**:
1. Right-click the `/content/dam/aemuniversaleditor/press/` folder
2. Select "Properties"
3. Go to "Cloud Services" tab
4. Ensure Edge Delivery Services configuration is assigned

### 5. json2html Service Configuration ⚠️
**Issue**: Service returning "Unauthorized"

**Possible Causes**:
- Token expired or invalid scopes
- Incorrect API endpoint configuration
- Service not properly configured

## Quick Tests

### Test 1: Verify Fragment Exists
```bash
# Test different possible API endpoints
curl -I "https://author-p8661-e624335.adobeaemcloud.com/api/assets/press/press1.json"
curl -I "https://author-p8661-e624335.adobeaemcloud.com/api/assets/aemuniversaleditor/press/press1.json"
```

### Test 2: Check Fragment via AEM Web Console
- URL: `https://author-p8661-e624335.adobeaemcloud.com/crx/de/index.jsp`
- Navigate to: `/content/dam/aemuniversaleditor/press/press1`
- Verify the fragment exists and has content

### Test 3: Test Direct AEM Access
```bash
# Try accessing the fragment directly in AEM
curl -I "https://author-p8661-e624335.adobeaemcloud.com/content/dam/aemuniversaleditor/press/press1.html"
```

## Configuration Fixes Needed

### Fix 1: Reconfigure json2html Service
The service needs proper authentication and correct configuration.

### Fix 2: Update paths.json if needed
Current mapping: `/content/dam/aemuniversaleditor/press/:/press/`
- Verify this matches where you actually created the fragment

### Fix 3: Add Cloud Configuration
Ensure the DAM folder has the correct Edge Delivery Services cloud configuration.

## Action Plan

1. **✅ Verify Fragment Location**: Check exact path in AEM
2. **✅ Confirm Publication Status**: Ensure fragment is published
3. **✅ Check Cloud Configuration**: Assign EDS config to DAM folder
4. **✅ Reconfigure json2html**: Fix authentication issues
5. **✅ Test API Endpoint**: Verify fragment is accessible
6. **✅ Clear Caches**: Flush all caches if needed

## Expected URLs That Should Work

Once fixed:
- **Fragment API**: `https://author-p8661-e624335.adobeaemcloud.com/api/assets/aemuniversaleditor/press/press1.json`
- **EDS Fragment**: `https://main--aemuniversaleditor--sameryadav.aem.page/press/press1`
- **json2html Config**: `https://json2html.adobeaem.workers.dev/config/sameryadav/aemuniversaleditor/main`

## Most Likely Issues

1. **Fragment not published** (90% probability)
2. **Fragment created in wrong location** (50% probability)  
3. **Missing cloud configuration** (30% probability)
4. **json2html service authentication** (70% probability)
