# InfopanelAS3
Infopanel client on Adobe AIR for Windows and Mac OS X

![Infopanel application with InfoBlock and RSS feed]
(http://www.elibsystem.ru/sites/default/files/docs/infopanel/InfoPanelAir.png)

This module required drupal site with enabled module Infopanel from repo: https://github.com/borovinskiy/infopanel

## Manual

Russian: http://elibsystem.ru/docs/infopanel/apps

### Run under Windows

InfoPanel.exe -site "url" [-enableInfoBlock] [-rss "url"] [-color ffffff] [-background ffffff] [-css "url"]

#### Parameters

site - url-link on drupal baseUrl, where installed module Infopanel from repo: https://github.com/borovinskiy/infopanel

enableInfoBlock (optional) - param for enable InfoBlock from drupal module

css (optional) - url-link on css file where set styles for rss and infoblock html code.

color (optional) - text color 

background (optinal) - background color

## Screenshots

### Video only

![Infopanel video]
(http://www.elibsystem.ru/sites/default/files/docs/infopanel/InfoPanel-video.png)

### Video and RSS

![Infopanel video and rss]
(http://www.elibsystem.ru/sites/default/files/docs/infopanel/InfoPanel-rss.png)

### Video and InfoBlock

![Infopanel video and InfoBlock]
(http://www.elibsystem.ru/sites/default/files/docs/infopanel/InfoPanel-infoblock.png)

## Hardware requirements

Adobe AIR use video hardware acceleration. It good work on Mac mini. On Intel atom can be problems with video performance.
