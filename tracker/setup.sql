-- OKX × Dubai Cares Campaign Tracker — Supabase Setup
-- Run this in the Supabase SQL Editor

-- 1. Create the table
CREATE TABLE IF NOT EXISTS okx_outreach (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  handle TEXT,
  ig_url TEXT,
  wave TEXT CHECK (wave IN ('P1','P2','P3')) DEFAULT 'P3',
  okx_status TEXT DEFAULT 'OKX Listed',
  nationality TEXT,
  category TEXT,
  followers TEXT,
  gender TEXT,
  age_range TEXT,
  audience_location TEXT,
  contacted_by TEXT,
  date_contacted DATE,
  date_response DATE,
  status TEXT DEFAULT 'Not Contacted'
    CHECK (status IN ('Not Contacted','Contacted','Replied','Pro-bono Confirmed','Paid Confirmed','Declined','No Response')),
  compensation TEXT DEFAULT 'TBD'
    CHECK (compensation IN ('Pro-bono','Paid','TBD')),
  fee_quoted NUMERIC(10,2),
  fee_agreed NUMERIC(10,2),
  notes TEXT,
  hidden BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable RLS
ALTER TABLE okx_outreach ENABLE ROW LEVEL SECURITY;

-- 3. Allow full anonymous access (team-shared, no auth needed)
CREATE POLICY "anon_all" ON okx_outreach FOR ALL TO anon USING (TRUE) WITH CHECK (TRUE);

-- 4. Auto-update timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_updated_at
  BEFORE UPDATE ON okx_outreach
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- 5. Enable realtime
ALTER PUBLICATION supabase_realtime ADD TABLE okx_outreach;
