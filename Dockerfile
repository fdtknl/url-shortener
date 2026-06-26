# Use a lightweight Node.js runtime as the base image.
# See: https://hub.docker.com/_/node
FROM node:20-alpine

# Set the working directory inside the container.
# See: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#workdir
WORKDIR /app

# Copy only package manifests first so dependency installation can be cached.
# See: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#leverage-build-cache
COPY package*.json ./

# Install production dependencies only.
# See: https://docs.npmjs.com/cli/v10/commands/npm-install
RUN npm install --omit=dev

# Copy the rest of the application source into the image.
# See: https://docs.docker.com/engine/reference/builder/#copy
COPY . .

# Set the runtime environment for the app.
# See: https://docs.docker.com/engine/reference/builder/#env
ENV NODE_ENV=production

# Expose the port the Express server listens on.
# See: https://docs.docker.com/engine/reference/builder/#expose
EXPOSE 3000

# Start the application entrypoint.
# See: https://docs.docker.com/engine/reference/builder/#cmd
CMD ["node", "src/server.js"]
