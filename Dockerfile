FROM postgres

WORKDIR /usr/app

ENV POSTGRES_USER docker
ENV POSTGRES_PASSWORD docker
ENV POSTGRES_DB rails_blog_db_dev
