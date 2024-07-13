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
CREATE INDEX idx_super_id ON all_entries (super_id);
CREATE INDEX idx_entry_type ON all_entries (entry_type);

-- Create the random hex generator function
CREATE OR REPLACE FUNCTION generate_random_hex()
RETURNS TEXT AS $$
DECLARE
    hex_code_a TEXT;
    hex_code_b TEXT;
BEGIN
    hex_code_a := lpad(to_hex(floor(random() * 4294967295)::bigint), 8, '0');
    hex_code_b := lpad(to_hex(floor(random() * 4294967295)::bigint), 8, '0');
    RETURN hex_code_a || hex_code_b;
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


INSERT INTO all_entries (entry_type, name, info, data, order_index) VALUES ('MAsophie', '', '{"desc": "Sophie is a very funny cat although very bad at eating.", "date": "2010-07-10"}', '["sophie eating.jpg"]', 1);
INSERT INTO all_entries (entry_type, name, info, data, order_index) VALUES ('AAsophie', 'Not Nice Data', '{"desc": "Horrible data and not anything anyone wants to see on a lovely cat website.", "date": "2018-07-12"}', '["Screenshot from 2024-07-07 11-09-29-6a6d4249-c904-4b35-a710-f162c3a3b56b.webp", "Screenshot from 2024-07-07 11-15-31-d9dfe1a1-248d-41fe-8b01-193fdfedd341.webp"]', 1);
INSERT INTO all_entries (entry_type, name, info, data, order_index) VALUES ('AAsophie', 'Beautiful Sophie', '{"desc": "Such a lovely elegant cat who really believed she is the queen of all cats.", "date": null}', '["sophie_on_bed.jpg", "sophie_santa.jpg"]', 2);
