---
title: "ConfigManager"
date: 2024-08-09
draft: false
description: "Transparent Config management"
slug: "configmanager"
tags: ["project", "configmanager"]
---

# Config Manager 

ConfigManager is a configmanagement system for transparent management of configuration within application, whilst it can be used through its Go API directly, its main purpose is perhaps via the CLI (Command Line Interface).

It acts as a single pane of glass to all the appropriate backing stores where your config, including secrets are stored and retrieved from when required. 

- Why
 - transparency of required configuration items, clear is better than clever

 - Do not store secrets directly in git/code but rather use a "pointer" ability to store opaque values as tokens in the code directly
- secrets are not really secrets 

## config management as a concept - storage and retrieval (convention over magic)

Ideally an application should use a single file to define its injected configuration, whether its an .env file that gets sourced in 