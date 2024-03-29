SELECT
	c.name AS Diagnosis,
	SUM(CASE DAY(encounter_datetime) WHEN 1 THEN 1 ELSE 0 END) AS 1st,
	SUM(CASE DAY(encounter_datetime) WHEN 2 THEN 1 ELSE 0 END) AS 2nd,
	SUM(CASE DAY(encounter_datetime) WHEN 3 THEN 1 ELSE 0 END) AS 3rd,
	SUM(CASE DAY(encounter_datetime) WHEN 4 THEN 1 ELSE 0 END) AS 4th,
	SUM(CASE DAY(encounter_datetime) WHEN 5 THEN 1 ELSE 0 END) AS 5th,
	SUM(CASE DAY(encounter_datetime) WHEN 6 THEN 1 ELSE 0 END) AS 6th,
	SUM(CASE DAY(encounter_datetime) WHEN 7 THEN 1 ELSE 0 END) AS 7th,
	SUM(CASE DAY(encounter_datetime) WHEN 8 THEN 1 ELSE 0 END) AS 8th,
	SUM(CASE DAY(encounter_datetime) WHEN 9 THEN 1 ELSE 0 END) AS 9th,
	SUM(CASE DAY(encounter_datetime) WHEN 10 THEN 1 ELSE 0 END) AS 10th,
	SUM(CASE DAY(encounter_datetime) WHEN 11 THEN 1 ELSE 0 END) AS 11th,
	SUM(CASE DAY(encounter_datetime) WHEN 12 THEN 1 ELSE 0 END) AS 12th,
	SUM(CASE DAY(encounter_datetime) WHEN 13 THEN 1 ELSE 0 END) AS 13th,
	SUM(CASE DAY(encounter_datetime) WHEN 14 THEN 1 ELSE 0 END) AS 14th,
	SUM(CASE DAY(encounter_datetime) WHEN 15 THEN 1 ELSE 0 END) AS 15th,
	SUM(CASE DAY(encounter_datetime) WHEN 16 THEN 1 ELSE 0 END) AS 16th,
	SUM(CASE DAY(encounter_datetime) WHEN 17 THEN 1 ELSE 0 END) AS 17th,
	SUM(CASE DAY(encounter_datetime) WHEN 18 THEN 1 ELSE 0 END) AS 18th,
	SUM(CASE DAY(encounter_datetime) WHEN 19 THEN 1 ELSE 0 END) AS 19th,
	SUM(CASE DAY(encounter_datetime) WHEN 20 THEN 1 ELSE 0 END) AS 20th,
	SUM(CASE DAY(encounter_datetime) WHEN 21 THEN 1 ELSE 0 END) AS 21st,
	SUM(CASE DAY(encounter_datetime) WHEN 22 THEN 1 ELSE 0 END) AS 22nd,
	SUM(CASE DAY(encounter_datetime) WHEN 23 THEN 1 ELSE 0 END) AS 23rd,
	SUM(CASE DAY(encounter_datetime) WHEN 24 THEN 1 ELSE 0 END) AS 24th,
	SUM(CASE DAY(encounter_datetime) WHEN 25 THEN 1 ELSE 0 END) AS 25th,
	SUM(CASE DAY(encounter_datetime) WHEN 26 THEN 1 ELSE 0 END) AS 26th,
	SUM(CASE DAY(encounter_datetime) WHEN 27 THEN 1 ELSE 0 END) AS 27th,
	SUM(CASE DAY(encounter_datetime) WHEN 28 THEN 1 ELSE 0 END) AS 28th,
	SUM(CASE DAY(encounter_datetime) WHEN 29 THEN 1 ELSE 0 END) AS 29th,
	SUM(CASE DAY(encounter_datetime) WHEN 30 THEN 1 ELSE 0 END) AS 30th,
	SUM(CASE DAY(encounter_datetime) WHEN 31 THEN 1 ELSE 0 END) AS 31st,
	SUM(CASE WHEN DAY(encounter_datetime)IS NOT NULL THEN 1 ELSE 0 END) AS Totals
FROM openmrs.concept_name c 
LEFT JOIN openmrs.obs o ON c.concept_id = o.value_coded 
LEFT JOIN openmrs.encounter e ON o.encounter_id = e.encounter_id AND encounter_datetime BETWEEN '#startDate#' AND '#endDate#'
LEFT JOIN openmrs.person p ON p.person_id = o.person_id AND TIMESTAMPDIFF(YEAR, p.birthdate, '#startDate#') >= 5
WHERE 
   locale = 'en' AND c.locale_preferred = 1
   /*add all the concept names for diagnoses here*/
   AND c.name IN ('RTA',
	               'Diarrhoea with some dehydration',
						'Diarrhoea with severe dehydration' ,
						'Cholera',
						'Dysentery' ,
						'Gastroenterirtis' ,
						'Pneumonia',
						'Severe pneumonia',
						'Upper Respiratory Tract Infections',
						'Other Lower Respiratory tract infections',
						'Asthma',
						'Presumed Tuberculosis',
						'Suspected Malaria',
						'Malaria, confirmed',
						'Ear infection',
						'MALNUTRITION',
						'Anaemia',
						'Meningococcal Meningitis',
						'Other Meningitis',
						'NEONATAL SEPSIS',
						'Tetanus neonatorum',
						'Poliomyelitis',
						'Varicella',
						'Measles',
						'hepatitis',
						'Amoebiasis',
						'Mumps',
						'Typhoid fever',
						'SCHISTOSOMIASIS',
						'Intestinal Helminthiasis',
						'Eye Infection',
						'Tonsillitis',
						'Urinary tract infection',
						'Mental Disorder',
						'DENTAL DISORDERS',
						'Jiggers Infestation',
						'Diseases of the skin',
						'Down\'s syndrome',
						'Poisoning',
						'Road Traffic Injuries',
						'Deaths due to Road Traffic Injuries',
						'Violence related injuries',
						'Other injuries',
						'Sexual Violence',
						'Burns',
						'Snake Bites',
						'Dog Bites',
						'Other Bites',
						'Diabetes',
						'Epilepsy',
						'Other Convulsive Disorders',
						'Rheumatic fever',
						'Brucellosis',
						'Rickets',
						'Cerebral palsy',
						'Autism',
						'Tryponosomiasis',
						'YELLOW FEVER',
						'Viral Haemorrhagic Fever',
						'Rift Valley Fever',
						'Chikungunya',
						'Dengue',
						'Leishmaniasis',
						'Cutaneous leishmaniasis',
						'Suspected anthrax',
						'Suspected Childhood Cancers',
						'Hypoxaemia',
						'Road Traffic Accident'
						) 
   AND EXTRACT(DAY FROM '#startDate#') = 1 
   AND LAST_DAY('#startDate#') = '#endDate#'
   AND TIMESTAMPDIFF(MONTH, '#startDate#', '#endDate#') = 0
GROUP BY c.name ;
