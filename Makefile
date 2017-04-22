image_name     := kafka-manager
image_registry := dylanmei
bin_version    := 1.3.3.6
image_version  := $(bin_version)

.PHONY: build/image tag/image push/image

build/image:
	docker build \
		--build-arg "http_proxy=$(http_proxy)" \
		--build-arg "https_proxy=$(https_proxy)" \
		--tag $(image_name) .

tag/image: build/image
	docker tag $(image_name) $(image_registry)/$(image_name):$(image_version)

push/image: tag/image
	docker push $(image_registry)/$(image_name):$(image_version)
