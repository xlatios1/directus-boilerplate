FROM directus/directus:11.3.5

USER root
RUN corepack disable
RUN npm install -g pnpm@latest
USER node

WORKDIR /directus
RUN pnpm install
RUN pnpm add directus-extension-sync
RUN pnpm add @directus/extensions-sdk

COPY extensions/ extensions/
USER root
RUN chown -R node:node extensions
USER node

RUN for ext in $(ls extensions); do \
    echo "Building extension: $ext"; \
    cd extensions/$ext && \
    npm install && \
    npm run build || exit 1; \
    cd -; \
done