# to_lendo_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

## Environment Variables

This project uses environment variables to securely store sensitive configuration data, such as Supabase credentials.

### Setup

1. Copy the example environment file:

   ```bash
   cp .env.example .env
   ```

2. Edit the `.env` file and fill in your actual Supabase credentials:

   ```
   SUPABASE_URL=your_supabase_url_here
   SUPABASE_ANON_KEY=your_supabase_anon_key_here
   ```

3. **Important**: The `.env` file is already in `.gitignore` and will not be committed to version control. Never commit sensitive credentials to the repository.

### Security Notes

- The `.env` file contains sensitive information and should never be shared or committed
- Use `.env.example` as a template for other developers
- Each developer should create their own `.env` file with their credentials

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
