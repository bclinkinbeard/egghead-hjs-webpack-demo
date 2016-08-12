# Remember makefile *must* use tabs instead of spaces so use this vim line
# vi: set tabstop=4 shiftwidth=4 noexpandtab 
#
# Still have issues with stale images
#
# change the variables here
repo ?= surround
name ?= $$(basename "$(PWD)")
Dockerfile ?= Dockerfile
image ?= $(repo)/$(name)
container = $(name)
data ?= /var/media
destination ?= $(HOME)/ws/runtime
# the user name on the host nodes if a raspberry pi
user ?= node

# /dev/video0 needed for v4l2
# /dev/vchiq needed for mmal
# Punch the image directory out to the host. We are doing this because docker cp
# is way too slow
# port 5858 is the node debug port
# For some reason the src mapping no long works you cannot map
# -v $(PWD)/src:/home/$(user)/src 
flags ?= -p 8080:8080 -p 3000:3000 -p 5858:5858 

include surround.mk
