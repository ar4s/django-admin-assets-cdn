deploy:
	docker build \
		--build-arg PYTHON_VERSION=3.10 \
		--build-arg DJANGO_VERSION=4 \
		--build-arg RCLONE_CONFIG_DEFAULT_PROVIDER="${RCLONE_CONFIG_DEFAULT_PROVIDER}" \
    --build-arg RCLONE_CONFIG_DEFAULT_ENDPOINT="${RCLONE_CONFIG_DEFAULT_ENDPOINT}" \
		--secret id=rclone_access_key_id,src=/tmp/rclone_access_key_id \
		--secret id=rclone_secret_access_key,src=/tmp/rclone_secret_access_key \
    --progress=plain \
		.

