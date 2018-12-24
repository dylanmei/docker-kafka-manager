image_name     := kafka-manager
image_registry := dylanmei
gitref         := master
image_version  := 1.3.3.22
#image_version  := $(gitref)

.PHONY: build/image tag/image push/image

build/image:
	docker build \
		--build-arg "gitref=$(gitref)" \
		--tag $(image_name) .

tag/image: build/image
	docker tag $(image_name) $(image_registry)/$(image_name):latest
	docker tag $(image_name) $(image_registry)/$(image_name):$(image_version)

push/image: tag/image
	docker push $(image_registry)/$(image_name):latest
	docker push $(image_registry)/$(image_name):$(image_version)
