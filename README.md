# php-cli tool

The main purpose of this repository is to provide an interactive PHP shell so you can use to run basic PHP and composer commands to craft the PHP project skeleton on any computer just by using docker. 

# Usage

## Step 1

Build the image

```
./docker-build.sh
```

## Step 2

Run it

```
./run.sh
```

## Step 3

Login to the container shell and use PHP commands or composer

```
./letmein.sh
```

After logging in, please navigate to the folder /data by

```
cd /data
```

Use it as the folder to share the data between the container and the host.