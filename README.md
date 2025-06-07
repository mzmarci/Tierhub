## Tierhub

## Tierhub 3-Tier App Locally - Debugging & Resolutions Log

##  Project Overview

The project consists of three tiers:

Web Tier: React frontend running on port 3000

App Tier: Node.js backend (API) running on port 4000

Database Tier: MySQL database

-- First start with installing node.js,npm and mysql on your terminal

## Error 1: MySQL Connection - ER_NOT_SUPPORTED_AUTH_MODE

## Problem

After starting the app tier using npm start, I encountered this error:

## Error: ER_NOT_SUPPORTED_AUTH_MODE: Client does not support authentication protocol requested by server

## Resolution

Logged into MySQL:

mysql -u marci -p -h localhost tierdb

Ran the following SQL command to update the user's authentication plugin:

ALTER USER 'marci'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
FLUSH PRIVILEGES;

##  Error 2: Cannot find module 'mysql'

## Problem

When running npm start, Node.js could not find the MySQL module.

##  Error: Cannot find module 'mysql'

##  Resolution

Installed the missing module:

npm install mysql

##  Error 3: Cannot GET / on http://localhost:4000

## Problem

When opening the app-tier URL directly (http://localhost:4000), the browser showed:

Cannot GET /

## Resolution

The app-tier is a backend API server. The correct API endpoint is:

http://localhost:4000/transaction

Verified that it returned:

{"result":[]}

This means the app-tier is working but the database is currently empty.

##  Error 4: Connecting Web Tier to App Tier

##  Problem

Web tier was not communicating with the app tier properly.

