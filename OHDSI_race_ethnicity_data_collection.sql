#Overall statistics

SELECT race_concept_id, ethnicity_concept_id, CASE WHEN count(*) > 10 THEN count(*) ELSE 10 END as cnt from
[database_name].[schema_name].person p
group by  race_concept_id, ethnicity_concept_id

#Race and ethnicity by year of first visit in visit_occurrence table

###SQL Server

SELECT race_concept_id, ethnicity_concept_id, CASE WHEN count(*) > 10 THEN count(*) ELSE 10 END as cnt,year(first_visits.visit_start_date) from
(SELECT person_id, min(visit_start_date) as visit_start_date
  FROM [database_name].[schema_name].[visit_occurrence] vo
  group by vo.person_id) first_visits
left join [database_name].[schema_name].person p on p.person_id = first_visits.person_id
group by  race_concept_id, ethnicity_concept_id, year(first_visits.visit_start_date)

###Oracle and Postgres

SELECT race_concept_id, ethnicity_concept_id, CASE WHEN count(*) > 10 THEN count(*) ELSE 10 END as cnt,EXTRACT(year from first_visits.visit_start_date) as first_visit_date from
(SELECT person_id, min(visit_start_date) as visit_start_date
  FROM [database_name].[schema_name].[visit_occurrence] vo
  group by vo.person_id) first_visits
left join [database_name].[schema_name].person p on p.person_id = first_visits.person_id
group by  race_concept_id, ethnicity_concept_id, EXTRACT(year from first_visits.visit_start_date)