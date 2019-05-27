FROM ubuntu

LABEL maintainer="Alessander Viana<alessander.viana@hotmail.com>"

ENV LANG=C.UTF-8 \
    MIX_ENV=test

# Configure the WORKDIR
RUN mkdir /app
WORKDIR /app

# Copy local code into the container WORKDIR
COPY . /app

RUN apt-get update && apt-get install -y wget gnupg2 \
    && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
    && dpkg -i erlang-solutions_1.0_all.deb \
    && apt-get update \
    && apt-get install -y esl-erlang \
    && apt-get install -y elixir \
    && apt-get clean \
    && mix local.hex --force \
    && mix local.rebar --force \
    && mix archive.install --force hex phx_new 1.4.3 \
    && mix deps.get

EXPOSE 4000

CMD ["mix", "phx.server"]
