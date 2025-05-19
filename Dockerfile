FROM node:20-alpine

WORKDIR /app

# Install pnpm and typescript globally
RUN npm install -g pnpm typescript

# Copy package files first for better caching
COPY package.json pnpm-lock.yaml tsconfig.json ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source code
COPY src ./src
COPY .env.example ./

# Build the TypeScript code
RUN pnpm build

CMD ["node", "dist/bin/cli.js"]