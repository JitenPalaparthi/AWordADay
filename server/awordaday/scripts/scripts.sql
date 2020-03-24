CREATE TABLE IF NOT EXISTS  words
(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    word STRING unique NOT NULL,
    meaning STRING NOT NULL,
    type STRING NOT NULL,
    status STRING NOT NULL DEFAULT 'NOT-ACTIVE',
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by STRING NOT NULL
);

CREATE TABLE IF NOT EXISTS  sentences
(
     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
     word_id UUID NOT NULL REFERENCES words (id),
     sentence STRING NOT NULL,
     status STRING NOT NULL DEFAULT 'NOT-ACTIVE',
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by STRING NOT NULL
);

-- Additional Status 
Create Table IF NOT EXISTS todaysWord
(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    word_id UUID NOT NULL REFERENCES words (id),
    today DATE NOT NULL,
    status STRING NOT NULL DEFAULT 'NOT-ACTIVE',
);


-- Additional Status 
Create Table IF NOT EXISTS request_words
(   
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    word STRING unique NOT NULL,
    status STRING NOT NULL DEFAULT 'Created',
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    requested_by STRING NOT NULL
);

CREATE TABLE IF NOT EXISTS  audits
(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    data STRING NOT NULL,
    ip STRING NOT NULL,
    device STRING NOT NULL,
    url_path STRING NOT NULL ,
    headers STRING NOT NULL ,
    date_time STRING NOT NULL
);