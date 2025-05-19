# Domain Radar MCP Server

FROM node:20-alpine

# Install pnpm
RUN npm install -g pnpm@8

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install all dependencies (both dev and prod for build)
RUN pnpm install --frozen-lockfile

# Copy source code and other necessary files
COPY . .

# Build the application
RUN pnpm build

# Remove dev dependencies
RUN pnpm prune --prod

# Set environment
ENV NODE_ENV=production

# MCP servers use stdio by default
CMD ["node", "dist/bin/cli.js", "stdio"]