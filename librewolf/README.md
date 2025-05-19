# userChrome.css feature

- [How to Create Your Own Firefox Theme with Firefox CSS - YouTube](https://www.youtube.com/watch?v=bw_M7q3Mtag)
- [How to make custom theme where we can modify close, max, min icons and also the tab sizes etc? - Add-ons / addons.mozilla.org - Mozilla Discourse](https://discourse.mozilla.org/t/how-to-make-custom-theme-where-we-can-modify-close-max-min-icons-and-also-the-tab-sizes-etc/123883)
- [userChrome.css for Customizing Firefox](https://www.userchrome.org/)
- [Browser Toolbox — Firefox Source Docs documentation](https://firefox-source-docs.mozilla.org/devtools-user/browser_toolbox/index.html)
- [Debugging | Firefox Extension Workshop](https://extensionworkshop.com/documentation/develop/debugging/#developer-tools-toolbox)


## Creating own userChrome.css

The userChrome.css file does not exist by default.

1. Since Firefox 69, you must go into about:config and set "toolkit.legacyUserProfileCustomizations.stylesheets" to "true" to enable these customizations. If you don't, Firefox will ignore your userChrome.css and userContent.css files.
2. Find your profile folder into about:support
3. Editing the userChrome.css. Save your changes and restart Firefox for them to take effect.
4. Finding resources and examples:

    - [Where to Find Style Recipes](https://www.userchrome.org/find-user-style-recipes.html)
    - [cascadefox/cascade: A responsive One-Line CSS Theme for Firefox.](https://github.com/cascadefox/cascade)
    - [ericmurphyxyz/userChrome.css: Couldn't find the perfect userChrome.css, so I made my own.](https://github.com/ericmurphyxyz/userChrome.css)
    - [Firefox 89+ – Styling the New Proton UI](https://www.userchrome.org/firefox-89-styling-proton-ui.html)
    - [Firefox CSS](https://www.reddit.com/r/FirefoxCSS/)

# WebExtension based themes (manifest.json)

- [Theme concepts - Mozilla | MDN](https://devdoc.net/web/developer.mozilla.org/en-US/docs/Mozilla/Add-ons/Themes/Theme_concepts.html)
- [A Beginners Guide to Making Custom Firefox Themes - Devtonight](https://devtonight.com/articles/a-beginners-guide-to-making-custom-firefox-themes)
- [theme - Mozilla | MDN](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json/theme)
- [theme\_experiment - Mozilla | MDN](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json/theme_experiment)

## How to import a json file you made in Firefox Color back to browser

Use *Install add-on from file* feature as described here [Add-ons for desktop apps | Firefox Extension Workshop](https://extensionworkshop.com/documentation/publish/distribute-sideloading/#install-addon-from-file)


