###Oracle and Postgres

#Overall statistics

SELECT race_concept_id, ethnicity_concept_id, CASE WHEN count(person_id) > 10 THEN count(person_id) ELSE 10 END as num_persons 
from [database_name].[schema_name].person p
group by  race_concept_id, ethnicity_concept_id
;

#Race and ethnicity of year of first observation period

SELECT race_concept_id, ethnicity_concept_id, observation_year, CASE WHEN count(first_op.person_id) > 10 THEN count(first_op.person_id) ELSE 10 END as num_persons 
from
(SELECT person_id, min(EXTRACT(year from observation_period_start_date)) as observation_year
  FROM [database_name].[schema_name].observation_period op
  group by op.person_id) first_op
inner join [database_name].[schema_name].person p on p.person_id = first_op.person_id
group by race_concept_id, ethnicity_concept_id, observation_year
;
