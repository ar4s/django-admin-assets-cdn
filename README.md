# Django Admin CDN
## Problem
Sometimes you build a Django project only for API to be consumed by other services or frontends.
In such cases, you may not need the full Django admin interface, but you still want to keep the admin URLs for potential future use or for specific administrative tasks.
However, including the static files for the admin interface can bloat your project (by adding extra steps in your build process) and increase load times unnecessarily.

## Solution
Django Admin CDN is a lightweight solution that serves static files for the Django admin interface from a Content Delivery Network (CDN) instead of bundling them with your project.
This reduces the size of your project and improves load times while still allowing you to use the admin interface when needed.

## Limitations
- This solution only serves static files for the Django admin interface.
- As I mentioned, this solution is intended for projects that serve only API and you don't have custom static files to serve.

# Default CDN
By default, repository uses Cloudflare R2 as a CDN for serving Django admin static files.
You can serve static files from https://django-admin-assets.source.net.pl/

# Configuration
To configure Django Admin CDN in your Django project, follow these steps:

1. Update your Django settings (replace `<VERSION-OF-DJANGO>` with the version you are using):
   ```python
   STATIC_URL = 'https://django-admin-assets.source.net.pl/<VERSION-OF-DJANGO>/'
   ```
2. Deploy your application.

# Supported versions
Django Admin CDN supports the following Django versions (values for `<VERSION-OF-DJANGO>`):
  - 5.2
  - 5.1
  - 5.0
  - 5
  - 4.2
  - 4.1
  - 4.0
  - 4

# FAQ
## Can I use a different CDN?
Yes, but you need to fork the repository and set up your own CDN to host the static files.
What you need besides that is:
  - to change the `STATIC_URL` in your Django settings to point to your CDN URL
  - provide secret and access keys for your CDN in secrets tab of your repository settings if you are using GitHub Actions for deployment.
## Should I use this in production?
Yes, using a CDN for serving static files is a common practice in production environments to improve performance and reduce server load.

