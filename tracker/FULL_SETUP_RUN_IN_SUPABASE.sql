-- OKX x Dubai Cares Tracker Setup
-- Paste this entire block in: Supabase Dashboard > SQL Editor > New Query > RUN

-- Step 1: Clear old tables
DROP TABLE IF EXISTS okx_reviews CASCADE;
DROP TABLE IF EXISTS okx_outreach CASCADE;

-- Step 2: Create tracker table
CREATE TABLE okx_outreach (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  handle TEXT, ig_url TEXT,
  wave TEXT CHECK (wave IN ('P1','P2','P3')) DEFAULT 'P3',
  okx_status TEXT DEFAULT 'OKX Listed',
  nationality TEXT, category TEXT, followers TEXT,
  gender TEXT, age_range TEXT, audience_location TEXT,
  contacted_by TEXT, date_contacted DATE, date_response DATE,
  status TEXT DEFAULT 'Not Contacted'
    CHECK (status IN ('Not Contacted','Contacted','Replied','Pro-bono Confirmed','Paid Confirmed','Declined','No Response')),
  compensation TEXT DEFAULT 'TBD'
    CHECK (compensation IN ('Pro-bono','Paid','TBD')),
  fee_quoted NUMERIC(10,2), fee_agreed NUMERIC(10,2),
  notes TEXT, hidden BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Step 3: Enable access (anyone with the link can use the tracker)
ALTER TABLE okx_outreach ENABLE ROW LEVEL SECURITY;
CREATE POLICY anon_all ON okx_outreach FOR ALL TO anon USING (TRUE) WITH CHECK (TRUE);

-- Step 4: Enable realtime sync
ALTER PUBLICATION supabase_realtime ADD TABLE okx_outreach;

-- Step 5: Load all 72 creators
INSERT INTO okx_outreach (name,handle,ig_url,wave,okx_status,nationality,category,followers,gender) VALUES
('Lojain Omran','@lojain_omran','https://www.instagram.com/lojain_omran/','P1','OKX Approved','Saudi Arabian','Lifestyle / Mega','11.7M','Female'),
('Mustafa Agha','@musta_agha','https://www.instagram.com/musta_agha/','P1','OKX Listed','Syrian-British','Journalism / MBC','4.5M','Male'),
('Khalid Al Ameri','@khalidalameri','https://www.instagram.com/khalidalameri/','P1','Our Pick','Emirati','Lifestyle / Storytelling','3M','Male'),
('Anas Bukhash','@ANASBOUKHASH','https://www.instagram.com/ANASBOUKHASH/','P1','OKX Approved','Emirati','Entrepreneur / Talk Show','3M','Male'),
('Sham Idrees','@shamidrees','https://www.instagram.com/shamidrees/','P1','Our Pick','UAE','Family / Lifestyle','2M+','Male'),
('Mohammad Galadari','@thisisgaladari','https://www.instagram.com/thisisgaladari/','P1','Our Pick','UAE','Crypto / Finance','888K','Male'),
('Mohammed Alsaadi','@xaex','https://www.instagram.com/xaex/','P1','Our Pick','UAE','Crypto / Arab KOL','784K','Male'),
('Nourhan Elgouhary','@nourhanelgouhary','https://www.instagram.com/nourhanelgouhary/','P1','Our Pick','Egyptian-UAE','Lifestyle / Modest','710K','Female'),
('Amrita Sethi','@art.by.amrita','https://www.instagram.com/art.by.amrita/','P1','Our Pick','UAE','NFT / Art','675K','Female'),
('Haifa Beseisso','@flywithhaifa','https://www.instagram.com/flywithhaifa/','P1','OKX Listed','Palestinian','Travel / Culture','500K+','Female'),
('Mahira Abdelaziz','@mahiraabdelaziz','https://www.instagram.com/mahiraabdelaziz/','P1','OKX Approved','Emirati','Media Personality',NULL,'Female'),
('Mayssoun Azzam','@mayssounazzam','https://www.instagram.com/mayssounazzam/','P1','OKX Approved','Palestinian','Al Arabiya Anchor',NULL,'Female'),
('Tapas Mohanta','@legendoftrading','https://www.instagram.com/legendoftrading/','P1','Our Pick','India-UAE','Crypto / Expat','238K','Male'),
('Matthias Mende','@mende','https://www.instagram.com/mende/','P1','Our Pick','European-UAE','Startup / Crypto','203K','Male'),
('Maitha Al Hashemi','@maithav','https://www.instagram.com/maithav/','P1','OKX Approved','Emirati','Lifestyle / Culture',NULL,'Female'),
('Mohamed S Thani','@mthani1','https://www.instagram.com/mthani1/','P2','OKX Approved','UAE','Lifestyle',NULL,'Male'),
('Haya Kaabar','@thedubailist','https://www.instagram.com/thedubailist/','P2','OKX Approved','UAE','Dining / Lifestyle',NULL,'Female'),
('Yousef Alkaabi','@yousef_alkaabi','https://www.instagram.com/yousef_alkaabi/','P2','OKX Approved','UAE','Arabic Content',NULL,'Male'),
('Live With Aziz','@livewithaziz','https://www.instagram.com/livewithaziz/','P2','OKX Approved','UAE','Finance / Lifestyle',NULL,'Male'),
('Anthony Rahayel','@nogarlicnoonions','https://www.instagram.com/nogarlicnoonions/','P2','OKX Approved','Lebanese','Culinary / Food',NULL,'Male'),
('Aziz Almarzouqi Fex','@fex','https://www.instagram.com/fex/','P2','OKX Approved','Emirati','Personality / Youth',NULL,'Male'),
('Miled Rahal','@miledrahal','https://www.instagram.com/miledrahal/','P2','OKX Approved','Lebanese','Lifestyle / Fashion',NULL,'Male'),
('Ali and Walaa','@aliandwalaa','https://www.instagram.com/aliandwalaa/','P2','OKX Approved','Lebanese','Couple / Family',NULL,'Couple / Team'),
('Moayad AlSawaf','@moayad.alsawaf','https://www.instagram.com/moayad.alsawaf/','P2','OKX Approved','UAE','Fine Dining',NULL,'Male'),
('Taim AlFalasi','@taimalfalasi','https://www.instagram.com/taimalfalasi/','P2','OKX Approved','UAE','Travel / Lifestyle',NULL,'Female'),
('Megan Al Marzooqi','@realmumsuae','https://www.instagram.com/realmumsuae/','P2','OKX Approved','Emirati','Parenting',NULL,'Female'),
('Mohamed Zidan','@Zidan_DXB','https://www.instagram.com/Zidan_DXB/','P2','OKX Listed','Egyptian','Sport / Lifestyle',NULL,'Male'),
('Ali F Mostafa','@alimostafa','https://www.instagram.com/alimostafa/','P2','OKX Listed','Emirati','Film / Creative',NULL,'Male'),
('Dima Al Sharif','@dimasharifonline','https://www.instagram.com/dimasharifonline/','P2','OKX Listed','Palestinian','Food / Middle Eastern',NULL,'Female'),
('Zozo Kahramana','@zozokahramana','https://www.instagram.com/zozokahramana/','P2','OKX Listed','UAE','Humor / Lifestyle',NULL,NULL),
('Daan de Rover CryptoRover','@cryptorover','https://www.instagram.com/cryptorover/','P2','Our Pick','Dutch-UAE','Crypto','52.5K','Male'),
('Lilly Douse','@lillydouse','https://www.instagram.com/lillydouse/','P2','Our Pick','UAE','Lifestyle / Crypto','45.9K','Female'),
('Rama Murad','@raamamurad','https://www.instagram.com/raamamurad/','P2','OKX Listed',NULL,'Lifestyle / Fashion',NULL,'Female'),
('Farah Abdulhamed','@farahabdulhamed','https://www.instagram.com/farahabdulhamed/','P2','OKX Listed','Jordanian','Beauty / Lifestyle',NULL,'Female'),
('Maria Frackowiak','@merys_way','https://www.instagram.com/merys_way/','P2','Our Pick','European-UAE','Lifestyle / Micro','8.5K','Female'),
('Aziza Faryal CryptoGirlUAE','@cryptogirluae','https://www.instagram.com/cryptogirluae/','P3','Our Pick','UAE','Crypto / Female',NULL,'Female'),
('Zahra Abdalla','@cookingwithzahra','https://www.instagram.com/cookingwithzahra/','P3','OKX Listed','Iran-Sudan','Food / Cookbook',NULL,'Female'),
('Lisa Helly Obrien','@MyLittleLovesBlog','https://www.instagram.com/MyLittleLovesBlog/','P3','OKX Listed',NULL,'Family / Parenting',NULL,'Female'),
('Alex Augusti JustFoodDXB','@justfooddxb','https://www.instagram.com/justfooddxb/','P3','OKX Listed','UAE','Food / Dining',NULL,'Male'),
('Lavina Israni','@lavinaisranicom','https://www.instagram.com/lavinaisranicom/','P3','OKX Listed','UAE','Food / Lifestyle',NULL,'Female'),
('Karen Mcclean Secret Squirrel','@secretsquirrelfood','https://www.instagram.com/secretsquirrelfood/','P3','OKX Listed','Australian-UAE','Food Blog',NULL,'Female'),
('Mona Essawi','@cookingis.art','https://www.instagram.com/cookingis.art/','P3','OKX Listed','UAE-Egypt','Healthy Lifestyle',NULL,'Female'),
('Nahla Ibrahim','@nahlaaibrahiim','https://www.instagram.com/nahlaaibrahiim/','P3','OKX Listed','Saudi-Egypt','Lifestyle',NULL,'Female'),
('Virdah Javed Khan','@mom_in_dubai','https://www.instagram.com/mom_in_dubai/','P3','OKX Listed','Pakistan-UAE','Mom / Lifestyle',NULL,'Female'),
('Aaisha','@dubai_blogger__','https://www.instagram.com/dubai_blogger__/','P3','OKX Listed','India-UAE','Food / Fashion',NULL,'Female'),
('Rafeez Ahmed','@tableeforone','https://www.instagram.com/tableeforone/','P3','OKX Listed','India-UAE','Food Blog',NULL,'Male'),
('Safia Mansoor','@cuptaleswithsafia','https://www.instagram.com/cuptaleswithsafia/','P3','OKX Listed','India-UAE','Food / Travel',NULL,'Female'),
('Ayshafarhana Tharammal','@ayeshas_kitche_n','https://www.instagram.com/ayeshas_kitche_n/','P3','OKX Listed','India-UAE','Lifestyle',NULL,'Female'),
('Olena','@health_and_beauty_uae','https://www.instagram.com/health_and_beauty_uae/','P3','OKX Listed','UAE','Food / Wellness',NULL,'Female'),
('Sultan Kayed','@sultan.eats','https://www.instagram.com/sultan.eats/','P3','OKX Listed','UAE','Chef / Food',NULL,'Male'),
('Pooja Varyani','@foodishvibes','https://www.instagram.com/foodishvibes/','P3','OKX Listed','India-UAE','Vegetarian Food',NULL,'Female'),
('Anushree Bagzai','@anushreebagzai','https://www.instagram.com/anushreebagzai/','P3','OKX Listed','India-UAE','Travel / Food',NULL,'Female'),
('Arpita Soni','@foodloreuae','https://www.instagram.com/foodloreuae/','P3','OKX Listed','India-UAE','Food Blog',NULL,'Female'),
('Jedax Foodtrip','@jedax.foodtrip','https://www.instagram.com/jedax.foodtrip/','P3','OKX Listed','Philippines-UAE','Food / Travel',NULL,'Male'),
('Syed Muhammad Shabi','@shaybishah','https://www.instagram.com/shaybishah/','P3','OKX Listed','Pakistan-UAE','Food Blog',NULL,'Male'),
('Aemen Aisha','@adventuresofaemen','https://www.instagram.com/adventuresofaemen/','P3','OKX Listed','Pakistan-UAE','Lifestyle',NULL,'Female'),
('Danah Alshayji','@danaindxb','https://www.instagram.com/danaindxb/','P3','OKX Listed','Kuwaiti-UAE','Mom / Lifestyle',NULL,'Female'),
('Hupert Sepidnam Mr Taster','@mr.taster','https://www.instagram.com/mr.taster/','P3','OKX Listed','UK-UAE','Food Blog',NULL,'Male'),
('Nawar H','@nawar.h6','https://www.instagram.com/nawar.h6/','P3','OKX Listed',NULL,'Lifestyle / Fashion',NULL,'Female'),
('Firas Nour','@firas.nour','https://www.instagram.com/firas.nour/','P3','OKX Listed',NULL,'Travel / Adventure',NULL,'Male'),
('Nouran M Fawzy','@nmfeats','https://www.instagram.com/nmfeats/','P3','OKX Listed',NULL,'Food / Lifestyle',NULL,'Female'),
('Lovin Dubai','@lovindubai','https://www.instagram.com/lovindubai/','P3','OKX Listed','UAE','Media / Lifestyle',NULL,NULL),
('GRIT TONIC','@gritandtonic','https://www.instagram.com/gritandtonic/','P3','OKX Listed','UAE','Fitness / Wellness',NULL,NULL),
('Rooted Regimen','@rootedregimen','https://www.instagram.com/rootedregimen/','P3','OKX Listed','UAE','Wellness Brand',NULL,NULL),
('OutQore','@outqore','https://www.instagram.com/outqore/','P3','OKX Listed','UAE','Activities',NULL,NULL),
('Al Oula Radio','@aloulafm','https://www.instagram.com/aloulafm/','P3','OKX Listed','Emirati','Radio / Media','34.2K',NULL),
('UAE Barq','@uae_barq','https://www.instagram.com/uae_barq/','P3','OKX Listed','Emirati','Arabic News',NULL,NULL),
('TFG Emirates Cycle Challenge','@tfg7ecc','https://www.instagram.com/tfg7ecc/','P3','OKX Listed','UAE','Cycling',NULL,NULL),
('The National News','@thenationalnews','https://www.instagram.com/thenationalnews.com/','P3','OKX Approved','UAE','English Media',NULL,NULL),
('DU Telecom','@Du','https://www.instagram.com/Du/','P3','OKX Listed','UAE','Telecom Brand',NULL,'Brand / Media'),
('Etisalat e and','@etisalat','https://www.instagram.com/etisalat/','P3','OKX Listed','UAE','Telecom Brand',NULL,'Brand / Media'),
('Natuzzi Italia Dubai','@natuzzi.uae','https://www.instagram.com/natuzzi.uae/','P3','OKX Listed','Italian-UAE','Furniture Brand','24.7K','Brand / Media');
