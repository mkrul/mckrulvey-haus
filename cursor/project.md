# McKrulvey Haus - Project Structure

## Overview

McKrulvey Haus is a Rails 8 application for managing a homestead, built with a mobile-first design for iPad use throughout the house. The application uses Turbo and Stimulus for frontend interactions, Tailwind CSS for styling, and Solid Queue for background job processing.

## Root Directory

```
mckrulvey-haus/
├── app/                    # Main application code
├── bin/                    # Executable scripts
├── config/                 # Application configuration
├── db/                     # Database files and migrations
├── lib/                    # Custom libraries and tasks
├── log/                    # Application logs
├── public/                 # Static assets served directly
├── storage/                # Active Storage files
├── tmp/                    # Temporary files (cache, pids, etc.)
├── vendor/                 # Third-party code (JavaScript dependencies)
├── cursor/                 # Cursor IDE configuration
├── .dockerignore           # Files to exclude from Docker builds
├── .env.example            # Environment variable template
├── .gitignore              # Git ignore rules
├── config.ru               # Rack configuration
├── docker-compose.yml      # Docker Compose configuration (development)
├── docker-compose.production.yml  # Docker Compose (production)
├── Dockerfile              # Docker image definition
├── Gemfile                 # Ruby gem dependencies
├── Gemfile.lock            # Locked gem versions
├── Procfile.dev            # Foreman process file for development
├── Rakefile                # Rake task definitions
└── README.md               # Project documentation
```

## Application Structure (`app/`)

### Controllers (`app/controllers/`)

Handles HTTP requests and responses.

```
controllers/
├── application_controller.rb      # Base controller with shared logic
├── dashboard_controller.rb      # Main dashboard/home page
├── phone_numbers_controller.rb   # Manage SMS notification recipients
├── scheduled_tasks_controller.rb # Manage scheduled tasks/reminders
├── concerns/                      # Shared controller concerns
│
├── pantry/                        # Pantry feature namespace
│   ├── base_controller.rb         # Base controller for pantry features
│   └── dashboard_controller.rb    # Pantry dashboard (placeholder)
│
├── animals/                       # Animal care feature namespace
│   ├── base_controller.rb         # Base controller for animal features
│   └── dashboard_controller.rb    # Animal care dashboard (placeholder)
│
├── rabbitry/                      # Rabbitry feature namespace
│   ├── base_controller.rb         # Base controller for rabbitry features
│   └── dashboard_controller.rb    # Rabbitry dashboard (placeholder)
│
└── freezer/                       # Freezer tracker feature namespace
    ├── base_controller.rb         # Base controller for freezer features
    └── dashboard_controller.rb    # Freezer dashboard (placeholder)
```

**Key Controllers:**
- `DashboardController` - Root path, displays feature cards
- `PhoneNumbersController` - CRUD for SMS notification recipients
- `ScheduledTasksController` - CRUD for scheduled tasks with SMS reminders
- Feature controllers (pantry, animals, rabbitry, freezer) - Namespaced placeholders ready for feature development

### Models (`app/models/`)

ActiveRecord models representing database entities.

```
models/
├── application_record.rb    # Base model class
├── concerns/                # Shared model concerns
├── phone_number.rb          # SMS notification recipients
├── scheduled_task.rb         # Tasks with due dates and recurrence
└── notification.rb           # Tracks sent SMS notifications
```

**Model Relationships:**
- `PhoneNumber` has_many `Notification`
- `ScheduledTask` has_many `Notification`
- `Notification` belongs_to `PhoneNumber` and `ScheduledTask`

**Key Models:**
- `PhoneNumber` - Stores phone numbers for SMS notifications (name, number, active status)
- `ScheduledTask` - Tasks with due dates, recurrence rules, and notification timing
- `Notification` - Tracks SMS delivery status (pending, sent, failed)

### Views (`app/views/`)

ERB templates for rendering HTML.

```
views/
├── layouts/
│   ├── application.html.erb    # Main application layout with mobile navigation
│   ├── mailer.html.erb         # Email HTML layout
│   └── mailer.text.erb         # Email text layout
│
├── dashboard/
│   └── index.html.erb          # Home page with feature cards
│
├── phone_numbers/
│   ├── index.html.erb          # List all phone numbers
│   └── new.html.erb            # Add new phone number form
│
├── scheduled_tasks/
│   ├── index.html.erb          # List all scheduled tasks
│   ├── new.html.erb            # Create new task form
│   ├── edit.html.erb           # Edit task form
│   └── _form.html.erb          # Shared task form partial
│
├── pantry/dashboard/
│   └── index.html.erb          # Pantry dashboard (placeholder)
│
├── animals/dashboard/
│   └── index.html.erb          # Animal care dashboard (placeholder)
│
├── rabbitry/dashboard/
│   └── index.html.erb          # Rabbitry dashboard (placeholder)
│
├── freezer/dashboard/
│   └── index.html.erb          # Freezer tracker dashboard (placeholder)
│
└── pwa/                        # Progressive Web App files
    ├── manifest.json.erb       # PWA manifest
    └── service-worker.js       # Service worker script
```

**Layout Features:**
- Mobile-first design with bottom navigation bar
- Touch-friendly interface (44px minimum tap targets)
- Dark theme optimized for low-light environments
- Safe area support for iPad notches

### JavaScript (`app/javascript/`)

Stimulus controllers and application JavaScript.

```
javascript/
├── application.js                    # Main JavaScript entry point
└── controllers/
    ├── application.js                # Base Stimulus controller
    ├── index.js                      # Auto-loads all controllers
    ├── navigation_controller.js      # Manages bottom nav active state
    └── flash_controller.js           # Handles flash message dismissal
```

**Stimulus Controllers:**
- `navigation_controller` - Updates active navigation state based on current route
- `flash_controller` - Auto-dismisses flash messages after 5 seconds

### Jobs (`app/jobs/`)

Background job classes for asynchronous processing.

```
jobs/
├── application_job.rb              # Base job class
├── send_notification_job.rb        # Sends SMS via Twilio
└── schedule_notifications_job.rb    # Schedules notification jobs for upcoming tasks
```

**Job Flow:**
1. `ScheduleNotificationsJob` runs every 5 minutes (via recurring.yml)
2. Finds tasks due within the next hour
3. Creates `Notification` records for each active phone number
4. Schedules `SendNotificationJob` to run at the appropriate time
5. `SendNotificationJob` sends SMS via `SmsService`

### Services (`app/services/`)

Service objects encapsulating business logic.

```
services/
└── sms_service.rb                  # Twilio SMS integration
```

**SmsService:**
- Wraps Twilio REST API client
- Handles SMS message delivery
- Mocks SMS in development when Twilio credentials are missing
- Raises `DeliveryError` on Twilio API failures

### Assets (`app/assets/`)

Stylesheets and images.

```
assets/
├── stylesheets/
│   └── application.css             # Main stylesheet manifest
├── tailwind/
│   └── application.css             # Tailwind CSS source file
├── builds/
│   └── tailwind/
│       └── tailwind.css            # Compiled Tailwind CSS
└── images/                         # Image assets
```

**Tailwind Configuration:**
- Custom theme colors (barn-red, hay, forest, wheat, soil)
- Mobile-first utility classes
- Touch-friendly component classes (nav-item, feature-card, btn, etc.)
- Dark mode support

### Helpers (`app/helpers/`)

View helper methods.

```
helpers/
└── application_helper.rb            # Application-wide helpers
```

### Mailers (`app/mailers/`)

Email templates and logic.

```
mailers/
└── application_mailer.rb            # Base mailer class
```

## Configuration (`config/`)

### Core Configuration

```
config/
├── application.rb                   # Main application configuration
├── boot.rb                         # Boot sequence (loads dotenv, bundler, bootsnap)
├── environment.rb                   # Environment-specific config loader
├── routes.rb                       # URL routing definitions
├── database.yml                    # Database connection settings
├── puma.rb                         # Puma web server configuration
├── cable.yml                       # Action Cable configuration
├── storage.yml                     # Active Storage configuration
├── credentials.yml.enc             # Encrypted credentials
├── importmap.rb                    # JavaScript module mappings
├── recurring.yml                   # Solid Queue recurring job definitions
└── config.ru                       # Rack application configuration
```

### Environment Configurations (`config/environments/`)

```
environments/
├── development.rb                  # Development environment settings
├── production.rb                   # Production environment settings
└── test.rb                         # Test environment settings
```

**Production Configuration:**
- Disabled SSL enforcement (for local network deployment)
- Host authorization disabled (allows local network access)
- Logging configured for Docker (STDOUT)

### Initializers (`config/initializers/`)

Code that runs on application startup.

```
initializers/
├── assets.rb                       # Asset pipeline configuration
├── content_security_policy.rb      # CSP headers
├── filter_parameter_logging.rb    # Filters sensitive params from logs
├── inflections.rb                  # Custom pluralization rules
└── twilio.rb                       # Twilio client configuration
```

### Locales (`config/locales/`)

Internationalization files.

```
locales/
└── en.yml                          # English translations
```

## Database (`db/`)

```
db/
├── migrate/
│   ├── 20251210103055_create_phone_numbers.rb      # Phone numbers table
│   ├── 20251210103105_create_scheduled_tasks.rb    # Scheduled tasks table
│   └── 20251210103117_create_notifications.rb      # Notifications table
├── schema.rb                       # Current database schema
└── seeds.rb                        # Seed data
```

**Database Schema:**
- `phone_numbers` - SMS recipients (name, number, active)
- `scheduled_tasks` - Tasks with due dates, recurrence, notification timing
- `notifications` - SMS delivery tracking (links tasks to phone numbers)

## Routes (`config/routes.rb`)

**Main Routes:**
- `GET /` → `dashboard#index` (root)
- `GET /pantry` → `pantry/dashboard#index`
- `GET /animals` → `animals/dashboard#index`
- `GET /rabbitry` → `rabbitry/dashboard#index`
- `GET /freezer` → `freezer/dashboard#index`
- `GET /phone_numbers` → `phone_numbers#index`
- `POST /phone_numbers` → `phone_numbers#create`
- `DELETE /phone_numbers/:id` → `phone_numbers#destroy`
- `GET /scheduled_tasks` → `scheduled_tasks#index`
- `POST /scheduled_tasks` → `scheduled_tasks#create`
- `GET /scheduled_tasks/:id/edit` → `scheduled_tasks#edit`
- `PATCH /scheduled_tasks/:id` → `scheduled_tasks#update`
- `DELETE /scheduled_tasks/:id` → `scheduled_tasks#destroy`

## Docker Configuration

### Docker Files

```
├── Dockerfile                      # Multi-stage production build
├── docker-compose.yml              # Development environment
├── docker-compose.production.yml   # Production environment
└── .dockerignore                   # Files excluded from Docker builds
```

**Docker Services:**
- `web` - Rails application server (port 3000)
- `worker` - Solid Queue background job processor
- `db` - PostgreSQL 16 database (port 5432)

**Docker Volumes:**
- `postgres_data` - Persistent database storage
- `bundle_cache` - Cached Ruby gems

## Scripts (`bin/`)

```
bin/
├── rails                           # Rails command runner
├── rake                            # Rake task runner
├── setup                           # Initial setup script
├── dev                             # Start development server with Foreman
├── docker-entrypoint               # Docker container entrypoint
├── importmap                       # Importmap command
├── brakeman                        # Security scanner
├── rubocop                         # Code style checker
└── thrust                          # Thruster server command
```

## Dependencies

### Key Gems (`Gemfile`)

**Core:**
- `rails` (~> 8.0.3) - Web framework
- `pg` (~> 1.1) - PostgreSQL adapter
- `puma` (>= 5.0) - Web server

**Frontend:**
- `turbo-rails` - SPA-like navigation
- `stimulus-rails` - JavaScript framework
- `tailwindcss-rails` - CSS framework
- `importmap-rails` - JavaScript module management

**Background Jobs:**
- `solid_queue` - Background job processor
- `solid_cache` - Cache store
- `solid_cable` - Action Cable adapter

**SMS:**
- `twilio-ruby` - Twilio API client

**Development:**
- `dotenv` - Environment variable loading
- `debug` - Debugging tools
- `web-console` - Browser-based console

## Key Features

### 1. Mobile-First Design
- Bottom navigation bar for thumb access
- Touch-friendly interface (minimum 44px tap targets)
- Dark theme for low-light environments
- Responsive layout optimized for iPad

### 2. SMS Notifications
- Add/remove phone numbers for notifications
- Schedule tasks with due dates and recurrence
- Automatic SMS reminders via Twilio
- Background job processing with Solid Queue

### 3. Feature Modules
Four main feature areas (currently placeholders):
- **Pantry** - Food and supply tracking
- **Animals** - Pet care and feeding schedules
- **Rabbitry** - Breeding records and rabbit management
- **Freezer** - Frozen food inventory

### 4. Background Jobs
- `ScheduleNotificationsJob` - Runs every 5 minutes, finds upcoming tasks
- `SendNotificationJob` - Sends SMS messages at scheduled times
- Configured via `config/recurring.yml`

## Development Workflow

1. **Start Services:**
   ```bash
   docker compose up
   ```

2. **Run Migrations:**
   ```bash
   docker compose exec web ./bin/rails db:migrate
   ```

3. **Access Console:**
   ```bash
   docker compose exec web ./bin/rails console
   ```

4. **View Logs:**
   ```bash
   docker compose logs -f web
   ```

## Environment Variables

Required in `.env`:
- `TWILIO_ACCOUNT_SID` - Twilio account identifier
- `TWILIO_AUTH_TOKEN` - Twilio authentication token
- `TWILIO_PHONE_NUMBER` - Twilio phone number (E.164 format)

Docker automatically sets:
- `DATABASE_HOST` - Database container hostname
- `DATABASE_USERNAME` - Database username
- `DATABASE_PASSWORD` - Database password

## Testing

Currently no test suite configured (per project requirements). Tests can be added later if needed.

## Deployment

Production deployment uses `docker-compose.production.yml`:
- Single container with Rails + Solid Queue worker
- PostgreSQL database with persistent volume
- Environment variables from host system
- Health checks for all services

