<!-- Write a query to rank order the following table in MySQL by votes, display the rank as one of the columns. -->
<!-- CREATE TABLE votes ( name CHAR(10), votes INT ); INSERT INTO votes VALUES ('Smith',10), ('Jones',15), ('White',20), ('Black',40), ('Green',50), ('Brown',20); -->

<!-- HANDLING OF SAME VOTES [Here we are keeping previoud value and comparing with next one]-->
SELECT name,  if(votes = @votes , @rank, if(@votes := votes,@rank := @rank + 1,1)) AS rank,votes as votes FROM votes v, (SELECT @rank := 0,@votes:=NULL) r ORDER BY  votes desc;


<!-- Second Approach-->
SELECT
CASE
  WHEN @prevVote = votes THEN @curRanking
  WHEN @prevVote := votes THEN @curRanking := @curRanking+1
END AS rank,name,votes
FROM votes, (SELECT @curRanking:=0,@prevVote:=NULL) AS t
ORDER BY votes desc;