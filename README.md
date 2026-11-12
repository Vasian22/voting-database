# Election and Voting Management System

A relational database for voters, candidates, elections and votes, built with PostgreSQL.

## Schema

Tables: `elections`, `voters`, `candidates`, `votes`.

| Constraint | Where | What it prevents |
|---|---|---|
| UNIQUE | voters.email | Two voters registering with the same email address |
| CHECK (age >= 18) | voters.age | Registering a voter who is under 18 |
| UNIQUE (voter_id, election_id) | votes | The same voter casting more than one vote in the same election |
| FOREIGN KEY | votes -> voters, candidates, elections | Votes that point to a voter, candidate, or election that doesn't exist |

## Constraint tests

Each of these inserts was rejected by the database:

- Duplicate email: `duplicate key value violates unique constraint "voters_email_key"`
- Age 15: `new row for relation "voters" violates check constraint "voters_age_check"`
- Second vote in the same election: `duplicate key value violates unique constraint "votes_voter_id_election_id_key"`
- Non-existent voter (99): `insert or update on table "votes" violates foreign key constraint "votes_voter_id_fkey"`

## How to run

```
psql -d yourdb -f schema.sql
psql -d yourdb -f queries.sql
```

## Queries

1. List all candidates with the election they belong to (JOIN).
2. Count the votes each candidate received (JOIN + GROUP BY).
3. Show the winner of each election (hint: one approach is a subquery or ORDER BY + LIMIT per election).
4. Turnout per election: number of votes and the percentage of all registered voters.
5. List voters who have never voted (subquery with NOT IN, then rewrite with LEFT JOIN).
6. List voters who voted in both elections.
7. Find duplicate emails in voters (GROUP BY + HAVING). It returns nothing here, so explain why.
8. Show candidates with zero votes (LEFT JOIN).
9. Count votes per party across all elections.
10. Show voters whose age is above the average age (subquery).
