Up and running ES6 and React in under 6 minutes
===============================================
Here is the command set to run ES6 and React natively:

- Clone the repository

```
npm install
npm start
```

Now you can open `http://localhost:3000` and edit the source and it will hot
reload


Running under docker
===================
You can use a prebuilt docker image with and also prebuilt make file which makes
docker pulls and so forth

```
docker build -t <your repo>/egghead-hjs-webpack-demo .
docker run -dt -p 3000:3000 <your repo>/egghead-hjs-webpack-demo 
```


If you want to just use a prebuilt container then you can use:

```
docker run -dt -p 3000:3000 surround/egghead-jhs-webpack-demo
```

Then you can open `http://localhost:3000`

Explanation
-----------
http://stackoverflow.com/questions/33462123/connecting-webpack-dev-server-inside-a-docker-container-from-the-host
clarifies that what is happening is that it is running by default in iframe
mode, so you have get to it with `http://localhost:3000/webpack-dev-server/index.html`

If you want inline mode then you need to add `--inline` to the invocation and
then the `http://localhost:3000/index.html` works and this is what is the
package.json

