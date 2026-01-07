package:
	docker run --platform linux/amd64 --rm -v ${PWD}:/apps -w /apps alpine/k8s:1.23.15 sh -c "helm package aks-store-demo-chart/ && curl --request POST --form 'chart=@aks-store-demo-chart-1.0.0.tgz' --user $HELM_USER:$HELM_PASS $HELM_REPO"

install-nginx-controller:
	helm upgrade --install ingress-nginx ingress-nginx \
		--repo https://kubernetes.github.io/ingress-nginx \
		--namespace ingress-nginx --create-namespace \
		--set controller.service.type="NodePort"

install-app:
	helm upgrade \
        --install aks-store-demo aks-store-demo-chart/ \
        --namespace aks-store-demo \
        --create-namespace \
        --set orderService.image.tag=$CI_COMMIT_TAG \
        --set productService.image.tag=$CI_COMMIT_TAG \
        --set storeFront.image.tag=$CI_COMMIT_TAG \
        --set image.credentials.username=$DOCKER_REGISTRY_USER \
        --set image.credentials.password=$DOCKER_REGISTRY_PASSWORD \
        --set image.credentials.registry="https://index.docker.io/v1/" \
        --set image.credentials.email=$DOCKER_REGISTRY_EMAIL

install: install-nginx-controller install-app

uninstall-nginx-controller:
	helm uninstall ingress-nginx --namespace ingress-nginx
	sleep 15
	kubectl delete namespace ingress-nginx

uninstall:
	helm uninstall aks-store-demo --namespace aks-store-demo
	sleep 30
	kubectl delete namespace aks-store-demo

reset: uninstall install

clean: uninstall uninstall-nginx-controller