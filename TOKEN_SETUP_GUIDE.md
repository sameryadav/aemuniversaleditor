# ADMIN_API_TOKEN Setup Guide

This guide explains how to obtain the `ADMIN_API_TOKEN` required for configuring the json2html service for AEM Content Fragments.

## Prerequisites

- Adobe ID with access to your AEM as a Cloud Service environment
- Adobe Developer Console access
- Appropriate permissions to create API credentials

## Step-by-Step Instructions

### 1. Create Adobe Developer Console Project

1. **Go to Adobe Developer Console**
   - Visit: https://developer.adobe.com/console
   - Sign in with your Adobe ID

2. **Create or Select Project**
   - Click "Create new project" or select an existing project
   - Give your project a meaningful name (e.g., "AEM Universal Editor API")

3. **Add Experience Manager API**
   - Click "Add API"
   - Select "Experience Manager" from the list
   - Click "Next"

### 2. Configure OAuth Server-to-Server Credentials

1. **Select OAuth Server-to-Server**
   - Choose "OAuth Server-to-Server" as the authentication type
   - Click "Next"

2. **Configure Scopes**
   - Select the required scopes for your use case:
     - `openid` (required)
     - `AdobeID` (required)
     - `read_organizations` (required)
     - Additional scopes as needed for your specific requirements

3. **Complete Setup**
   - Review and create the credentials
   - Note down the following values:
     - **Client ID**
     - **Client Secret**
     - **Organization ID** (optional)

### 3. Generate Access Token

#### Option A: Using the Provided Script (Recommended)

1. **Set Environment Variables**
   ```bash
   export CLIENT_ID="your-client-id-from-console"
   export CLIENT_SECRET="your-client-secret-from-console"
   
   # Optional: Custom scopes (defaults are provided)
   export SCOPES="openid,AdobeID,read_organizations,additional_info.projectedProductContext"
   ```

2. **Run the Token Generation Script**
   ```bash
   ./scripts/generate-token.sh
   ```

3. **Use the Generated Token**
   ```bash
   # The script will output your token and optionally save it to .env
   source .env  # If you chose to save to .env file
   
   # Or manually export it
   export ADMIN_API_TOKEN="your-generated-token-here"
   ```

#### Option B: Manual cURL Command

```bash
curl -X POST https://ims-na1.adobelogin.com/ims/token/v3 \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=YOUR_CLIENT_ID" \
  -d "client_secret=YOUR_CLIENT_SECRET" \
  -d "grant_type=client_credentials" \
  -d "scope=openid,AdobeID,read_organizations"
```

### 4. Configure json2html Service

Once you have your `ADMIN_API_TOKEN`, run the configuration script:

```bash
export ADMIN_API_TOKEN="your-token-here"
./scripts/configure-json2html.sh
```

## Important Notes

### Token Expiration
- **Access tokens expire in 24 hours**
- You'll need to regenerate the token when it expires
- Consider setting up a renewal process for production environments

### Security Best Practices
- **Never commit tokens to version control**
- Store tokens securely in environment variables
- Use different tokens for different environments (dev/staging/prod)
- Regularly rotate your Client Secret

### Troubleshooting

#### Common Issues:

1. **"Invalid Client" Error**
   - Verify your Client ID and Client Secret are correct
   - Ensure the API is properly configured in Adobe Developer Console

2. **"Insufficient Scope" Error**
   - Check that you've selected the correct scopes in Adobe Developer Console
   - Add additional scopes if needed for your specific use case

3. **Token Doesn't Work**
   - Verify the token hasn't expired (24-hour limit)
   - Check that you're using the correct authorization header format: `Authorization: Bearer YOUR_TOKEN`

#### Debug Steps:

1. **Test Token Validity**
   ```bash
   curl -H "Authorization: Bearer $ADMIN_API_TOKEN" \
        "https://json2html.adobeaem.workers.dev/config/sameryadav/aemuniversaleditor/main"
   ```

2. **Check Token Details**
   - Use online JWT decoders to inspect token contents (if it's a JWT)
   - Verify expiration time and scopes

3. **Verify Adobe Developer Console Setup**
   - Ensure all required APIs are added to your project
   - Check that OAuth Server-to-Server is properly configured

## Alternative Methods

### For Development/Testing
If you're having trouble with the OAuth flow, you can also:

1. **Use Adobe CLI** (if available in your environment)
2. **Use Postman** with Adobe IMS authentication
3. **Contact your Adobe administrator** for pre-generated tokens

### For Production
Consider implementing:
- **Automated token renewal** in your CI/CD pipeline
- **Secure token storage** in your deployment environment
- **Token monitoring and alerting** for expiration

## Next Steps

After obtaining your token:
1. ✅ Set `ADMIN_API_TOKEN` environment variable
2. ✅ Run `./scripts/configure-json2html.sh`
3. ✅ Test content fragment publishing
4. ✅ Monitor token expiration and renewal

For additional help, refer to:
- [Adobe Developer Console Documentation](https://developer.adobe.com/developer-console/docs/)
- [AEM as a Cloud Service API Documentation](https://developer.adobe.com/experience-cloud/experience-manager-apis/)
- [OAuth Server-to-Server Authentication Guide](https://developer.adobe.com/developer-console/docs/guides/authentication/ServerToServerAuthentication/)
