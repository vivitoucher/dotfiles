// universal privacy and performance baseline configuration

// 1. disable tracking telemetries and metrics collection completely
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("experiments.supported", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");

// 2. secure the browser connection protocols
user_pref("dom.security.https_only_mode", true);
user_pref("network.security.esni.enabled", true);

// 3. clean user interface parameters for future ricing
user_pref("browser.toolbars.keyboard_navigation", true);
user_pref("browser.startup.page", 0); // start with a clean blank canvas
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
