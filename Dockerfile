FROM python:3.13-slim AS assets_producer

ARG DJANGO_VERSION

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=basic_project.settings
ENV STATIC_ROOT=/app/basic_project/var/static

RUN pip install django==${DJANGO_VERSION}
ADD basic_project /app/basic_project

WORKDIR /app/basic_project

RUN python manage.py collectstatic --noinput

RUN ls -la $STATIC_ROOT


FROM rclone/rclone

ARG DJANGO_VERSION
ARG RCLONE_CONFIG_DEFAULT_PROVIDER
ARG RCLONE_CONFIG_DEFAULT_ENDPOINT

ENV RCLONE_CONFIG_DEFAULT_TYPE=s3
ENV RCLONE_CONFIG_DEFAULT_PROVIDER=${RCLONE_CONFIG_DEFAULT_PROVIDER}
ENV RCLONE_CONFIG_DEFAULT_ENDPOINT=${RCLONE_CONFIG_DEFAULT_ENDPOINT}


COPY --from=assets_producer /app/basic_project/var/static /static
RUN --mount=type=secret,id=rclone_access_key_id \
  --mount=type=secret,id=rclone_secret_access_key \
  RCLONE_CONFIG_DEFAULT_ACCESS_KEY_ID="$(cat /run/secrets/rclone_access_key_id)" \
  RCLONE_CONFIG_DEFAULT_SECRET_ACCESS_KEY="$(cat /run/secrets/rclone_secret_access_key)" \
  rclone copy /static default:django/${DJANGO_VERSION}
