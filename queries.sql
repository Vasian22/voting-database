-- get each winner
WITH vote_counts AS (
    SELECT c.election_id, c.candidate_id, c.name,
           COUNT(v.vote_id) AS total_votes
    FROM candidates c
    JOIN votes v ON c.candidate_id = v.candidate_id
    GROUP BY c.election_id, c.candidate_id, c.name
)
SELECT vc.election_id, vc.name, vc.total_votes
FROM vote_counts vc
WHERE vc.total_votes = (
    SELECT MAX(vc2.total_votes)
    FROM vote_counts vc2
    WHERE vc2.election_id = vc.election_id
);
-- total votes
Select count(vote_id) as tot, name
from votes
inner join candidates
on votes.candidate_id=candidates.candidate_id
group by name;

--turnout from elections
SELECT election_id,
       COUNT(*) AS votes_cast,
       count(*)*100.0/(select count(*) from voters) AS turnout_pct
FROM votes
GROUP BY election_id;
--no voters
SELECT v.voter_id, v.name
FROM voters v
LEFT JOIN votes vt ON v.voter_id = vt.voter_id
WHERE v.voter_id is null

--or 
--no voters
SELECT v.voter_id, v.name
FROM voters v
WHERE v.voter_id not in (select voter_id from votes)

--election with their candidates
Select Name,title
from candidates c
inner join elections e
on c.election_id=e.election_id;
--duplicate email
Select name,email from voters 
group by name,email
having count(email) > 1
--total party votes count
SELECT c.party, COUNT(*) AS votes_received
FROM votes vt
JOIN candidates c ON vt.candidate_id = c.candidate_id
GROUP BY c.party;
--More than avg age
select * from voters 
where age> (select avg(age) from voters)