# Market Bot API

Market Bot API is a google store scraper (market_bot) exposed as a JSON API.

# Development

Install dependancies

`bundle install`

Run the development server

`rackup`

# API

## Applications

`GET /app/:id`

* `:id` - The android namespace for the application

```
GET /app/com.snapchat.android
--
{
  "success": true,
  "app": {
    "market_id":"com.snapchat.android",
    "title":"Snapchat",
    "category":"Social",
    "developer":"Snapchat, Inc.",
    "installs":"100,000,000 - 500,000,000",
    "price":"0",
    "votes":"2161924",
    "stars":"4.0",
    "stars_distribution":{
      "5":1216009,
      "4":379723,
      "3":236048,
      "2":118509,
      "1":211632
    },
    "updated":"November 17, 2014",
    "content_rating":"Medium Maturity",
    "icon_url":"https://lh4.ggpht.com/vdK_CsMSsJoYvJpYgaj91fiJ1T8rnSHHbXL0Em378kQaaf_BGyvUek2aU9z2qbxJCAFV=w300",
    "image_url":"https://lh4.ggpht.com/vdK_CsMSsJoYvJpYgaj91fiJ1T8rnSHHbXL0Em378kQaaf_BGyvUek2aU9z2qbxJCAFV=w300"
  }
}
```

## Developers

`GET /developer/:id`

* `:id` - The android developer name (capitalization and entities matter)

```
GET /developer/Color+Tiger
--
{
  "success": true,
    "developer_id":"Color+Tiger",
    "apps": [
      {
        "stars":"4.2",
        "title":"Smart Thermometer",
        "price":"Free",
        "developer":"Color Tiger",
        "market_id":"com.colortiger.thermo",
        "market_url":"https://play.google.com/store/apps/details?id=com.colortiger.thermo&hl=en"
      },
      {
        "stars":"4.6",
        "title":"Smart IR Remote - AnyMote",
        "price":"$7.90",
        "developer":"Color Tiger",
        "market_id":"com.remotefairy",
        "market_url":"https://play.google.com/store/apps/details?id=com.remotefairy&hl=en"
      },
      {
        "stars":"4.0",
        "title":"AnyMote - Smart TV Remote",
        "price":"Free",
        "developer":"Color Tiger",
        "market_id":"com.remotefairy4",
        "market_url":"https://play.google.com/store/apps/details?id=com.remotefairy4&hl=en"
      },
      {
        "stars":"4.5",
        "title":"Smart IR Remote for HTC One",
        "price":"$11.33",
        "developer":"Color Tiger",
        "market_id":"com.remotefairy2",
        "market_url":"https://play.google.com/store/apps/details?id=com.remotefairy2&hl=en"
      }
    ]
  }
}
```

## Leaderboards

Supported by market_bot, but not currently implemented in this API.

## Search

Supported by market_bot, but not currently implemented in this API.

