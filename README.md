# ethic-app
Frontend code for Ethic.


## Installation

You should have node installed. You can use [nvm](https://github.com/creationix/nvm).
Then you can do the following:
```bash
$ npm install -g gulp bower
$ npm install .
```


## Developing

We use browserify to bundle the files together. To build the files:
```bash
$ gulp build
```
Alternatively you can watch every file change using the following:
```bash
$ gulp watch
```

To start the test server, go to another shell and type:
```bash
$ npm start
```
