# ──────────────────────────────────────────────
# Stage 1: Build  (Vite + Node)
# ──────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Dependencies pehle copy karo (cache ke liye)
COPY package*.json ./
RUN npm ci

# Baaki saara code copy karo
COPY . .

# Production build banao
RUN npm run build
# Build output: /app/dist


# ──────────────────────────────────────────────
# Stage 2: Serve  (Nginx)
# ──────────────────────────────────────────────
FROM nginx:stable-alpine AS runner

# Apna nginx config use karo
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Vite build output → nginx html folder
COPY --from=builder /app/dist /usr/share/nginx/html

# Port expose karo
EXPOSE 80

# Nginx foreground mein chalao
CMD ["nginx", "-g", "daemon off;"]

