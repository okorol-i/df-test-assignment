ARG REGISTRY=""
ARG BASE_IMAGE_NODE=node:25-alpine

FROM ${REGISTRY}${REGISTRY:+/}${BASE_IMAGE_NODE} AS build

WORKDIR /app

COPY package.json ./
RUN npm install --omit=dev

COPY src ./src

FROM ${REGISTRY}${REGISTRY:+/}${BASE_IMAGE_NODE}

WORKDIR /app

ENV NODE_ENV=production

COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/src ./src

EXPOSE 8000

ENTRYPOINT ["node", "src/server.js"]
