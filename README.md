# Django Admin CDN
## Problem
Sometimes you build a Django project only for API to be consumed by other services or frontends. In such cases, you may not need the full Django admin interface, but you still want to keep the admin URLs for potential future use or for specific administrative tasks. However, including the static files for the admin interface can bloat your project and increase load times unnecessarily.

## Solution
Django Admin CDN is a lightweight solution that serves static files for the Django admin interface from a Content Delivery Network (CDN) instead of bundling them with your project. This reduces the size of your project and improves load times while still allowing you to use the admin interface when needed.
