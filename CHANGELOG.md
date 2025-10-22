## 0.0.4

- Fixed an issue where the fetched App Store version (especially on iOS and some Android stores) could be outdated due to CDN caching.
- Added `forceNoCache` parameter to allow forcing a fresh version check by bypassing store-side caching mechanisms.
- Improved consistency across App Store, Huawei AppGallery, and RuStore data sources to handle cache-busting correctly.

## 0.0.3

- add new method to return current installed version and store version.

## 0.0.2

- make update methode return bool.

## 0.0.1

- Initial Open Source release.
