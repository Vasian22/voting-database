-- Election and Voting Management System: schema + sample data
-- Works in PostgreSQL and SQLite.
-- Run (PostgreSQL):  psql -d yourdb -f schema.sql
-- Run (SQLite):      sqlite3 voting.db < schema.sql
-- Read every line and make sure you can explain it before you move on.

DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS candidates;
DROP TABLE IF EXISTS voters;
DROP TABLE IF EXISTS elections;

CREATE TABLE elections (
    election_id    INTEGER PRIMARY KEY,
    title          VARCHAR(100) NOT NULL,
    election_date  DATE NOT NULL
);

CREATE TABLE voters (
    voter_id  INTEGER PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    email     VARCHAR(150) NOT NULL UNIQUE,          -- no duplicate voter emails
    age       INTEGER NOT NULL CHECK (age >= 18)     -- only adults can register
);

CREATE TABLE candidates (
    candidate_id  INTEGER PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    party         VARCHAR(50),
    election_id   INTEGER NOT NULL,
    FOREIGN KEY (election_id) REFERENCES elections (election_id)
);

CREATE TABLE votes (
    vote_id       INTEGER PRIMARY KEY,
    voter_id      INTEGER NOT NULL,
    candidate_id  INTEGER NOT NULL,
    election_id   INTEGER NOT NULL,
    FOREIGN KEY (voter_id)     REFERENCES voters (voter_id),
    FOREIGN KEY (candidate_id) REFERENCES candidates (candidate_id),
    FOREIGN KEY (election_id)  REFERENCES elections (election_id),
    UNIQUE (voter_id, election_id)                   -- one vote per voter per election
);

-- ---------- sample data ----------
INSERT INTO elections VALUES (1, 'Student Council 2026', '2026-03-10');
INSERT INTO elections VALUES (2, 'Class Representative 2026', '2026-04-02');

INSERT INTO voters VALUES (1, 'Arun',   'arun@example.com',   19);
INSERT INTO voters VALUES (2, 'Bala',   'bala@example.com',   20);
INSERT INTO voters VALUES (3, 'Chitra', 'chitra@example.com', 21);
INSERT INTO voters VALUES (4, 'Divya',  'divya@example.com',  19);
INSERT INTO voters VALUES (5, 'Eswar',  'eswar@example.com',  22);
INSERT INTO voters VALUES (6, 'Farah',  'farah@example.com',  20);
INSERT INTO voters VALUES (7, 'Gokul',  'gokul@example.com',  23);
INSERT INTO voters VALUES (8, 'Harini', 'harini@example.com', 21);

INSERT INTO candidates VALUES (1, 'Anita',   'Unity',    1);
INSERT INTO candidates VALUES (2, 'Ravi',    'Progress', 1);
INSERT INTO candidates VALUES (3, 'Meena',   'Unity',    2);
INSERT INTO candidates VALUES (4, 'Karthik', 'Progress', 2);

INSERT INTO votes VALUES (1, 1, 1, 1);
INSERT INTO votes VALUES (2, 2, 2, 1);
INSERT INTO votes VALUES (3, 3, 1, 1);
INSERT INTO votes VALUES (4, 4, 1, 1);
INSERT INTO votes VALUES (5, 5, 2, 1);
INSERT INTO votes VALUES (6, 1, 3, 2);
INSERT INTO votes VALUES (7, 2, 4, 2);
INSERT INTO votes VALUES (8, 3, 3, 2);

-- ---------- constraint tests ----------
-- Run these ONE AT A TIME. Each should FAIL. Read the error message
-- and write down which constraint stopped it.
--
-- INSERT INTO voters VALUES (9, 'Test', 'arun@example.com', 25);   -- ?
-- INSERT INTO voters VALUES (9, 'Test', 'test@example.com', 15);   -- ?
-- INSERT INTO votes  VALUES (9, 1, 2, 1);                          -- ?
-- INSERT INTO votes  VALUES (9, 99, 1, 1);                         -- ?
