
run-containers:
	docker-compose -f ./deploy/docker/docker-compose.yaml up -d

stop-containers:
	docker-compose -f ./deploy/docker/docker-compose.yaml down

build-superset-image:
	docker build --platform linux/amd64 --progress=plain \
 		-f ./deploy/docker/superset/image/Dockerfile \
 		--tag "superset:0.0.1" \
 		./deploy/docker/superset/image/.