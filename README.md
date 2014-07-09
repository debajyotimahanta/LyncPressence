#Lync Presence Awareness 
This plugin will include presence awareness for a given person field. It works on IE, Chrome and Firefox. In order for this plugin to work. To install this plugin you can use bower
```javascript
bower install LyncPresencePlugin
```
Or you can install it via [Nuget](http://www.nuget.org/packages/LyncPresencePlugin/)
```sh
PM > Install-Package LyncPresencePlugin
```

### Requirments
+ You must have Lync client installed.
+ Needs jquery
+ You will need to include the main.css and images library in the styles folder.

### Overview
The way it works is you need to declare your class in the following name where presence needs to show in the following manner
```html
<div class="author" data-user-id="john.doe@xxx.net">John Doe</div>
```
1. It loops through all items which has class author
2. It uses data-user-id attribute value to construct the presence. So this id must be SPID
At end of the page you will see that i am initializing the object and calling InsertLyncs method which does the above two steps for you

```javascript
var x= new Lync();
x.InsertLyncs();
```
In order to see a sample setup, please refer to index.html file.
## Copyright and license

Code and documentation The MIT License (MIT) Copyright (c) 2014 debajyotimahanta
