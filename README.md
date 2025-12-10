# McKrulvey Haus

A mobile-first homestead management application built with Rails 8, Turbo, and Stimulus.

## Features

- **Pantry Tracker** - Track food and household supplies
- **Animal Care** - Manage pet feeding schedules and care tasks
- **Rabbitry** - Breeding records and rabbit management
- **Freezer Tracker** - Manage frozen food inventory
- **SMS Notifications** - Task reminders via Twilio

## Prerequisites

- Docker & Docker Compose (recommended)
- Git

## Quick Start with Docker

### 1. Clone the Repository

```bash
git clone <repository-url>
cd mckrulvey-haus
```

### 2. Configure Environment Variables

Copy the example environment file:

```bash
cp .env.example .env
```

Edit `.env` and add your Twilio credentials:
- Get your Account SID and Auth Token from [Twilio Console](https://console.twilio.com/)
- Purchase a phone number or use a trial number

```bash
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_auth_token_here
TWILIO_PHONE_NUMBER=+15551234567
```

**Note:** If you don't have Twilio credentials yet, you can leave these blank for now. The app will run but SMS notifications won't work.

### 3. Start Docker Containers

Build and start all services (database, web server, and background worker):

```bash
docker compose up --build
```

This will:
- Build the Docker images
- Start PostgreSQL database
- Start the Rails web server
- Start the Solid Queue worker for background jobs

The first build may take several minutes as it installs all dependencies.

### 4. Set Up the Database

In a new terminal window, run the database migrations:

```bash
docker compose exec web ./bin/rails db:create db:migrate
```

### 5. Access the Application

Open your browser and navigate to:

```
http://localhost:3000
```

You should see the McKrulvey Haus dashboard!

## Docker Commands Reference

### Start Services

```bash
# Start in foreground (see logs)
docker compose up

# Start in background (detached mode)
docker compose up -d

# Rebuild containers after code changes
docker compose up --build
```

### Stop Services

```bash
# Stop containers (keeps data)
docker compose stop

# Stop and remove containers (keeps volumes)
docker compose down

# Stop and remove everything including volumes (⚠️ deletes database)
docker compose down -v
```

### Run Rails Commands

```bash
# Run migrations
docker compose exec web ./bin/rails db:migrate

# Open Rails console
docker compose exec web ./bin/rails console

# Run any Rails command
docker compose exec web ./bin/rails <command>
```

### View Logs

```bash
# All services
docker compose logs

# Specific service
docker compose logs web
docker compose logs worker
docker compose logs db

# Follow logs (like tail -f)
docker compose logs -f web
```

### Access Container Shell

```bash
# Web container
docker compose exec web bash

# Database container
docker compose exec db sh
```

## Development Without Docker

If you prefer to run locally without Docker:

### Prerequisites

- Ruby 3.3.3
- PostgreSQL
- Node.js (for Tailwind CSS)

### Setup Steps

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Configure environment variables:**
   ```bash
   cp .env.example .env
   # Edit .env with your credentials
   ```

3. **Set up database:**
   ```bash
   ./bin/rails db:create db:migrate
   ```

4. **Start the application:**
   ```bash
   ./bin/dev
   ```

   This starts both the Rails server and Tailwind CSS watcher.

5. **Access the app:**
   ```
   http://localhost:3000
   ```

## Environment Variables

The application uses a `.env` file for local development. This file is gitignored and should never be committed.

### Required Variables

- `TWILIO_ACCOUNT_SID` - Your Twilio Account SID
- `TWILIO_AUTH_TOKEN` - Your Twilio Auth Token
- `TWILIO_PHONE_NUMBER` - Your Twilio phone number (E.164 format, e.g., +15551234567)

### Docker Variables

When using Docker Compose, database variables (`DATABASE_HOST`, `DATABASE_USERNAME`, `DATABASE_PASSWORD`) are automatically set by `docker-compose.yml`. You don't need to configure these manually.

## Architecture

### Services

- **web** - Rails application server (port 3000)
- **worker** - Solid Queue background job processor
- **db** - PostgreSQL database (port 5432)

### Key Technologies

- **Rails 8** - Web framework
- **Turbo** - SPA-like page navigation
- **Stimulus** - Client-side JavaScript framework
- **Tailwind CSS** - Mobile-first styling
- **Solid Queue** - Background job processing
- **PostgreSQL** - Database
- **Twilio** - SMS notifications

## Troubleshooting

### Port Already in Use

If port 3000 is already in use:

```bash
# Find what's using the port
lsof -i :3000

# Or change the port in docker-compose.yml
# Edit the ports section: "3001:3000" instead of "3000:3000"
```

### Database Connection Errors

If you see database connection errors:

```bash
# Check if database container is running
docker compose ps

# Restart the database
docker compose restart db

# Wait for database to be healthy, then retry
docker compose exec web ./bin/rails db:create db:migrate
```

### Container Build Issues

If builds fail:

```bash
# Clean rebuild (removes cache)
docker compose build --no-cache

# Remove old containers and volumes
docker compose down -v
docker compose up --build
```

### View Container Logs

```bash
# All services
docker compose logs

# Specific service with timestamps
docker compose logs -f --timestamps web
```

## Production Deployment

For local network deployment:

```bash
docker compose -f docker-compose.production.yml up -d
```

Make sure to set all required environment variables in your production environment or `.env` file.

## License

Private project
