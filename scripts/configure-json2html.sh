#!/bin/bash

# Configuration script for json2html service
# This script configures the json2html service for AEM Content Fragments overlay

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}AEM Content Fragments json2html Service Configuration${NC}"
echo "=========================================================="

# Check if required environment variables are set
if [ -z "$ADMIN_API_TOKEN" ]; then
    echo -e "${RED}Error: ADMIN_API_TOKEN environment variable is not set${NC}"
    echo "Please set your admin API token:"
    echo "export ADMIN_API_TOKEN='your-admin-api-token-here'"
    exit 1
fi

if [ -z "$AEM_AUTHOR_INSTANCE" ]; then
    echo -e "${YELLOW}Warning: AEM_AUTHOR_INSTANCE not set, using default from fstab.yaml${NC}"
    AEM_AUTHOR_INSTANCE="https://author-p8661-e624335.adobeaemcloud.com"
fi

if [ -z "$AEM_PUBLISH_INSTANCE" ]; then
    echo -e "${YELLOW}Warning: AEM_PUBLISH_INSTANCE not set, using default${NC}"
    AEM_PUBLISH_INSTANCE="https://publish-p8661-e624335.adobeaemcloud.com"
fi

echo "Configuring json2html service for:"
echo "- Author Instance: $AEM_AUTHOR_INSTANCE"
echo "- Publish Instance: $AEM_PUBLISH_INSTANCE"
echo ""

# Configure the json2html service
echo "Sending configuration to json2html service..."

curl --request POST \
  --url https://json2html.adobeaem.workers.dev/config/sameryadav/aemuniversaleditor/main \
  --header "Authorization: token $ADMIN_API_TOKEN" \
  --header 'Content-Type: application/json' \
  --data "[
    {
      \"path\": \"/press/\",
      \"endpoint\": \"$AEM_AUTHOR_INSTANCE/api/assets/aemuniversaleditor/press/{{id}}.json\",
      \"regex\": \"/[^/]+$/\",
      \"template\": \"/cf-templates/press.html\",
      \"relativeURLPrefix\": \"$AEM_PUBLISH_INSTANCE\",
      \"headers\": {
        \"Accept\": \"application/json\"
      },
      \"forwardHeaders\": [
        \"Authorization\"
      ]
    }
  ]"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ json2html service configured successfully!${NC}"
else
    echo -e "${RED}✗ Failed to configure json2html service${NC}"
    exit 1
fi

echo ""
echo "Configuration complete!"
echo ""
echo "Next steps:"
echo "1. Create the Mustache template at /cf-templates/press.html"
echo "2. Test by publishing a content fragment to Edge Delivery Services"
echo ""
echo "To verify the configuration, visit:"
echo "https://json2html.adobeaem.workers.dev/config/sameryadav/aemuniversaleditor/main"
