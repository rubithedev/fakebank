FROM oven/bun:1.3.14-alpine AS build
WORKDIR /build
COPY . .
RUN bun install
RUN bun run build


FROM oven/bun:1.3.14-alpine AS app
WORKDIR /app
COPY --from=build /build/dist dist
COPY package.json .
RUN bun install --production

CMD [ "bun", "run", "dist/main.js" ]
