IMAGE_NAME := "toodo/cert-manager-webhook-dnspod"
IMAGE_TAG := "latest"

OUT := $(shell pwd)/_out

$(shell mkdir -p "$(OUT)")

verify:
	go test -v .

build:
	docker buildx build --platform=linux/amd64,linux/arm64 -t "$(IMAGE_NAME):$(IMAGE_TAG)" . --push

.PHONY: rendered-manifest.yaml
rendered-manifest.yaml:
	helm template \
	    --name cert-manager-webhook-dnspod \
        --set image.repository=$(IMAGE_NAME) \
        --set image.tag=$(IMAGE_TAG) \
        deploy/cert-manager-webhook-dnspod > "$(OUT)/rendered-manifest.yaml"
