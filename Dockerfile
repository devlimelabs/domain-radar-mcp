FROM node:20

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml tsconfig.json ./

# Install pnpm and dependencies
RUN npm install -g pnpm
RUN pnpm install

# Copy source
COPY src/ ./src/
COPY .env.example ./

# Build
RUN pnpm build

# Set environment
ENV NODE_ENV=production

# Run
CMD ["node", "dist/index.js"]