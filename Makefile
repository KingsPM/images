## Generic Image builder
# David Brawand <dbrawand@nhs.net>

# repo
REPO := "kingspm"

# Image Directories
DIRECTORIES := $(dir $(wildcard */))
IMAGES := $(DIRECTORIES:/=)

build: setbuild images

push: login setpush images

pull: setpull images

login:
	docker login
setbuild:
	$(eval TASK := build)
setpush:
	$(eval TASK := push)
setpull:
	$(eval TASK := pull)

.PHONY: images $(IMAGES)

images: $(IMAGES)

$(IMAGES):
	$(eval TARGET := $@)
	@echo "##########" $(TASK) $(TARGET) "##########"
	@if [ "$(TASK)" = "build" ]; then\
		docker build -t $(REPO)/$(TARGET) $(TARGET);\
	elif [ "$(TASK)" = "pull" ]; then\
		docker pull $(REPO)/$(TARGET);\
	elif [ "$(TASK)" = "push" ]; then\
		docker push $(REPO)/$(TARGET);\
	fi
