# What to Do Next - Content Fragments Setup

## 🚨 Important: Why You Got a 404

The URL `https://main--aemuniversaleditor--sameryadav.aem.page/press.html` returns 404 because:

1. **No content fragment named "press" exists**
2. **No regular page at `/press.html` exists**  
3. **Your setup is for individual content fragments, not general pages**

## ✅ Correct URL Patterns

### For Content Fragments:
- Pattern: `/press/{fragment-name}` (no .html extension)
- Example: `https://main--aemuniversaleditor--sameryadav.aem.page/press/latest-news`

### For Regular Pages:
- Pattern: `/page-name.html`
- Example: `https://main--aemuniversaleditor--sameryadav.aem.page/press.html` (if you create a press page)

## 🛠️ Two Solutions

### Option 1: Create Content Fragments (Recommended)

**Step 1: Create Content Fragment in AEM**
1. Access AEM Assets: `https://author-p8661-e624335.adobeaemcloud.com/assets.html`
2. Navigate to: `/content/dam/aemuniversaleditor/press/`
3. Create a new Content Fragment:
   - Name: `test-press-release`
   - Model: Create or use existing model with fields like:
     - title (text)
     - summary (text)  
     - content (rich text)
     - author (text)

**Step 2: Publish the Fragment**
- In AEM, select the content fragment
- Click "Publish" (Quick Publish)

**Step 3: Access the Fragment**
- URL: `https://main--aemuniversaleditor--sameryadav.aem.page/press/test-press-release`

### Option 2: Create a Press Landing Page

**Step 1: Create Regular Page in AEM**
1. Access AEM Sites: `https://author-p8661-e624335.adobeaemcloud.com/sites.html`
2. Navigate to: `/content/aemuniversaleditor/`
3. Create new page: "press"
4. Add content and publish

**Step 2: Access the Page**
- URL: `https://main--aemuniversaleditor--sameryadav.aem.page/press.html`

## 🔧 Current Configuration Status

### ✅ Working:
- Basic Edge Delivery Services site
- File configurations (fstab.yaml, paths.json)
- Mustache template created
- Scripts available

### ⚠️ Needs Attention:
- json2html service authorization (may need different token scopes)
- No content fragments created yet
- No test content to verify overlay

## 🧪 Quick Test

**Test your basic site first:**
```bash
# Should return 200 OK
curl -I https://main--aemuniversaleditor--sameryadav.aem.page/

# Test existing pages (if any)
curl -I https://main--aemuniversaleditor--sameryadav.aem.page/index.html
```

## 📋 Immediate Action Plan

1. **✅ Verify basic site works** (already confirmed)
2. **🔄 Create a test content fragment in AEM**
3. **📤 Publish the content fragment**  
4. **🌐 Test access via `/press/fragment-name`**
5. **🐛 Debug json2html service if needed**

## 🚨 Common Misunderstandings

**❌ Wrong Assumption**: "I should be able to access `/press.html` immediately"  
**✅ Reality**: You need actual content (fragments or pages) first

**❌ Wrong URL**: `/press.html`  
**✅ Correct URL**: `/press/actual-fragment-name`

## 🔗 Key URLs for Your Setup

- **AEM Author**: https://author-p8661-e624335.adobeaemcloud.com
- **EDS Site**: https://main--aemuniversaleditor--sameryadav.aem.page/
- **Content Fragments Path**: `/content/dam/aemuniversaleditor/press/`
- **Fragment URL Pattern**: `/press/{fragment-name}`

## 🎯 Success Criteria

You'll know it's working when:
1. ✅ You can create content fragments in AEM
2. ✅ Fragments publish successfully
3. ✅ URLs like `/press/my-fragment` return content (not 404)
4. ✅ Content renders using your Mustache template

## ⏰ Next 15 Minutes

1. Go to AEM Assets
2. Create one simple test content fragment
3. Publish it
4. Test the URL pattern
5. Come back with results!

The 404 is expected right now - you just need content to serve! 🚀
