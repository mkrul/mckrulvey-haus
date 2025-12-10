# McKrulvey Haus

A mobile-first homestead management application built with Rails 8, Turbo, and Stimulus.

## Features

- **Pantry Tracker** - Track food and household supplies
- **Animal Care** - Manage pet feeding schedules and care tasks
- **Rabbitry** - Breeding records and rabbit management
- **Freezer Tracker** - Manage frozen food inventory
- **SMS Notifications** - Task reminders via Twilio

## Prerequisites

- Ruby 3.3.3
- PostgreSQL
- Docker & Docker Compose (recommended)

## Setup

### 1. Clone and Install Dependencies

```bash
bundle install
```

### 2. Configure Environment Variables

Copy the example environment file and fill in your Twilio credentials:

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

### 3. Database Setup

**With Docker (Recommended):**
```bash
docker compose up -d
docker compose exec web ./bin/rails db:create db:migrate
```

**Without Docker:**
```bash
./bin/rails db:create db:migrate
```

### 4. Run the Application

**With Docker:**
```bash
docker compose up
```

The app will be available at http://localhost:3000

**Without Docker:**
```bash
./bin/dev
```

This starts both the Rails server and Tailwind CSS watcher.

## Environment Variables

The application uses a `.env` file for local development. This file is gitignored and should never be committed.

### Required Variables

- `TWILIO_ACCOUNT_SID` - Your Twilio Account SID
- `TWILIO_AUTH_TOKEN` - Your Twilio Auth Token
- `TWILIO_PHONE_NUMBER` - Your Twilio phone number (E.164 format)

### Docker Variables

When using Docker Compose, database variables are automatically set. For production, set these in your environment or `docker-compose.production.yml`.

## Development

- The app uses Turbo for SPA-like navigation
- Stimulus controllers handle client-side interactions
- Tailwind CSS for styling (mobile-first design)
- Solid Queue for background job processing

## Production Deployment

For local network deployment:

```bash
docker compose -f docker-compose.production.yml up -d
```

Make sure to set all required environment variables in your production environment.

## License

Private project
