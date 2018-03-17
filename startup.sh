#!/bin/bash
#thin $@ -V -R config.ru start
shotgun --server=thin --port=40000 --host 0.0.0.0  config.ru 
