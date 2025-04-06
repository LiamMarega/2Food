class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://mjoxycdldkxmrhbnwqsu.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1qb3h5Y2RsZGt4bXJoYm53cXN1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgzNTM0NzAsImV4cCI6MjA1MzkyOTQ3MH0.W7F5Yi7E80lisgyLwYxGb-7VdJ_NBaDOHzvvwtOoG9s',
  );
}
