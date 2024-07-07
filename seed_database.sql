-- Create the table
CREATE TABLE all_entries (
  id SERIAL PRIMARY KEY,
  super_id TEXT UNIQUE,
  entry_type text,
  name text,
  info jsonb,
  data jsonb,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  order_index INTEGER
);

-- Create the random hex generator function
CREATE OR REPLACE FUNCTION generate_random_hex()
RETURNS TEXT AS $$
DECLARE
    hex_code TEXT;
BEGIN
    hex_code := lpad(to_hex(floor(random() * 4294967295)::bigint), 8, '0');
    RETURN hex_code;
END;
$$ LANGUAGE plpgsql;

-- Create the function to assign the random hex to super_id
CREATE OR REPLACE FUNCTION assign_super_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.super_id := generate_random_hex();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER assign_super_id_trigger
BEFORE INSERT ON all_entries
FOR EACH ROW
EXECUTE FUNCTION assign_super_id();


INSERT INTO all_entries (entry_type, name, data, order_index) VALUES ('Asophie', 'name1', '["Screenshot from 2024-07-07 11-09-29-6a6d4249-c904-4b35-a710-f162c3a3b56b.webp", "Screenshot from 2024-07-07 11-15-31-d9dfe1a1-248d-41fe-8b01-193fdfedd341.webp"]', 1);
