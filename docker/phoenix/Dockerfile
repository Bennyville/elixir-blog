FROM elixir:latest

RUN apt-get update && \
	apt-get install -y postgresql-client

RUN mkdir /app
COPY ./src /app
WORKDIR /app

RUN mix local.hex --force && \
	mix local.rebar --force

RUN mix archive.install --force hex phx_new

CMD ["/app/entrypoint.sh"]

