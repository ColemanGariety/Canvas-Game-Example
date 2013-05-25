# Brains With Friends!

Make friends. Blast zombies. Eat brains. Find true love.  

(For now) a super simple Node.js Express application to host the game code for a single-player zombie experience.  
Once the renderer, models, and game logic is in a playable state on the frontend it will be mirrored on the Node.js server, persisted in MongoDB, and streamed in realtime to users to allow for collaborative zombie blasting.


## Prerequisites
**Required Global NPM Installs**  
Coffee-Script: ```npm install -g coffee-script```
JS Bundler: ```npm install -g browserify```

**Optional Global NPM Installs**  
File Watched: ```npm install -g node-mon```
Debugger: ```npm install -g node-inspector```

**Within Project Directory**  
```npm install```


## Development Notes
**Compiling JavaScript**  
One-off: ``` browserify -c 'coffee -sc' frontend/scripts/application.coffee > public/scripts/zombie-game.js```
NodeMon Auto Compilation: ```nodemon -w frontend/ -x "browserify -c 'coffee -sc' frontend/scripts/application.coffee > public/scripts/zombie-game.js"```

**Compiling CSS**  
```sass --watch frontend/styles:public/styles```


## Miscellaneous
[Client / Server Conceptual Design](https://developer.valvesoftware.com/wiki/Latency_Compensating_Methods_in_Client/Server_In-game_Protocol_Design_and_Optimization)