#!/bin/bash

# Script to generate ADMIN_API_TOKEN for AEM Edge Delivery Services
# This script helps you obtain an OAuth access token from Adobe IMS

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Adobe IMS Access Token Generator${NC}"
echo "===================================="
echo ""

# Check if required environment variables are set
if [ -z "$CLIENT_ID" ]; then
    echo -e "${RED}Error: CLIENT_ID environment variable is not set${NC}"
    echo "Please set your Adobe Developer Console Client ID:"
    echo "export CLIENT_ID='your-client-id-here'"
    echo ""
    echo "Get this from: https://developer.adobe.com/console"
    exit 1
fi

if [ -z "$CLIENT_SECRET" ]; then
    echo -e "${RED}Error: CLIENT_SECRET environment variable is not set${NC}"
    echo "Please set your Adobe Developer Console Client Secret:"
    echo "export CLIENT_SECRET='your-client-secret-here'"
    echo ""
    echo "Get this from: https://developer.adobe.com/console"
    exit 1
fi

if [ -z "$SCOPES" ]; then
    echo -e "${YELLOW}Warning: SCOPES not set, using default${NC}"
    SCOPES="openid,AdobeID,read_organizations,additional_info.projectedProductContext,additional_info.roles"
fi

echo "Generating access token..."
echo "Client ID: ${CLIENT_ID:0:8}..."
echo "Scopes: $SCOPES"
echo ""

# Generate the access token
RESPONSE=$(curl -s -X POST https://ims-na1.adobelogin.com/ims/token/v3 \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CLIENT_SECRET" \
  -d "grant_type=client_credentials" \
  -d "scope=$SCOPES")

# Check if the request was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Failed to connect to Adobe IMS${NC}"
    exit 1
fi

# Extract the access token from the response
ACCESS_TOKEN=$(echo "$RESPONSE" | grep -o '"access_token":"[^"]*' | grep -o '[^"]*$')

if [ -z "$ACCESS_TOKEN" ]; then
    echo -e "${RED}✗ Failed to obtain access token${NC}"
    echo "Response from Adobe IMS:"
    echo "$RESPONSE"
    exit 1
fi

echo -e "${GREEN}✓ Access token generated successfully!${NC}"
echo ""
echo "Your ADMIN_API_TOKEN:"
echo "=============================="
echo "$ACCESS_TOKEN"
echo "=============================="
echo ""
echo "To use this token, set it as an environment variable:"
echo "export ADMIN_API_TOKEN='$ACCESS_TOKEN'"
echo ""
echo -e "${YELLOW}Note: This token expires in 24 hours${NC}"
echo ""

# Optionally save to a file
read -p "Save token to .env file? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "ADMIN_API_TOKEN='$ACCESS_TOKEN'" > .env
    echo -e "${GREEN}✓ Token saved to .env file${NC}"
    echo "You can now run: source .env"
fi

echo ""
echo "Next step: Run the json2html configuration script:"
echo "./scripts/configure-json2html.sh"
