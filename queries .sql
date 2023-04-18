--1--
SELECT  DISTINCT ON (Diseases.name) Diseases.name ,Diseases.born_country,Diseases.born_year,Diseases.mortality_rate
FROM Diseases
WHERE Diseases.name='disease_name';

--2--
SELECT DISTINCT Diseases.name 
FROM Diseases 
WHERE name LIKE 'starting_characters%';

--3--
SELECT Treatment.name,Treatment.type ,Treatment.description
FROM Treatment
WHERE Treatment.id IN (
    SELECT Has_Treatment.Treatment_id 
    FROM Has_Treatment 
    WHERE Has_Treatment.Disease_id IN (
        SELECT Diseases.id 
        FROM Diseases 
        WHERE Diseases.name='disease_name'
));

--4--
SELECT Prevention.description 
FROM Prevention
WHERE Prevention.Disease_id IN (
    SELECT Diseases.id 
    FROM Diseases
    WHERE Diseases.name='disease_name'

);

--5--
SELECT Medicine.name,Medicine.prescription ,Medicine.side_effects
FROM Medicine
WHERE Medicine.id IN (
    SELECT Has_Medicine.Medicine_id 
    FROM Has_Medicine 
    WHERE Has_Medicine.Disease_id IN (
        SELECT Diseases.id 
        FROM Diseases 
        WHERE Diseases.name='disease_name'
));

--6--
SELECT Types_of_tests.name,Types_of_tests.description
FROM Types_of_tests
WHERE Types_of_tests.id IN (
    SELECT Identification_test.test_id 
    FROM Identification_test 
    WHERE Identification_test.Disease_id IN (
        SELECT Diseases.id 
        FROM Diseases 
        WHERE Diseases.name='disease_name'
));

--7--
SELECT Types_of_symptoms.name
FROM Types_of_symptoms
WHERE Types_of_symptoms.id IN (
    SELECT Has_symptoms.symptom_id 
    FROM Has_symptoms 
    WHERE Has_symptoms.Disease_id IN (
        SELECT Diseases.id 
        FROM Diseases 
        WHERE Diseases.name='disease_name'
));

--8--
SELECT Vaccines.name
FROM Vaccines
WHERE Vaccines.id IN (
    SELECT Has_Vaccine.Vaccine_id 
    FROM Has_Vaccine 
    WHERE Has_Vaccine.Disease_id IN (
        SELECT Diseases.id 
        FROM Diseases 
        WHERE Diseases.name='disease_name'
));

--9--
SELECT Transmission_modes.name ,Transmission_modes.description
FROM Transmission_modes
WHERE Transmission_modes.id IN (
    SELECT Modes_of_Transmission.Transmission_id
    FROM Modes_of_Transmission 
    WHERE Modes_of_Transmission.Disease_id IN (
        SELECT Diseases.id 
        FROM Diseases 
        WHERE Diseases.name='disease_name'
));

--10--
SELECT DISTINCT Treatment.name 
FROM Treatment 
WHERE name LIKE 'starting_characters%';

--11--
SELECT DISTINCT Transmission_modes.name 
FROM Transmission_modes 
WHERE name LIKE 'starting_characters%';

--12--
SELECT DISTINCT Medicine.name 
FROM Medicine 
WHERE name LIKE 'starting_characters%';

--13--
SELECT DISTINCT Vaccines.name 
FROM Vaccines 
WHERE name LIKE 'starting_characters%';

--14--
SELECT DISTINCT Types_of_tests.name 
FROM Types_of_tests 
WHERE name LIKE 'starting_characters%';

--15--
SELECT DISTINCT Types_of_symptoms.name 
FROM Types_of_symptoms 
WHERE name LIKE 'starting_characters%';

--16--
SELECT Treatment.name,Treatment.type ,Treatment.description
FROM Treatment
WHERE Treatment.name='treatment_name';

--17--
SELECT Types_of_tests.name,Types_of_tests.description
FROM Types_of_tests
WHERE Types_of_tests.name='test_name';

--18--
SELECT Has_Medicine.Dosage
FROM Has_Medicine
WHERE Has_Medicine.Medicine_id=(
    SELECT Medicine.id 
    FROM Medicine
    WHERE Medicine.name='medicine_name'
)
AND Has_Medicine.Disease_id=(
    SELECT Diseases.id
    FROM Diseases
    WHERE Diseases.name='disease_name'
);
--19--
SELECT DISTINCT Diseases.name
FROM Diseases
WHERE Diseases.id IN(
    SELECT Has_Medicine.Disease_id
    FROM Has_Medicine
    WHERE Has_Medicine.Medicine_id IN(
        SELECT Medicine.id
        FROM Medicine
        WHERE Medicine.name='medicine_name'
    )
);

--20--
SELECT DISTINCT Diseases.name
FROM Diseases
WHERE Diseases.id IN(
    SELECT Has_Treatment.Disease_id
    FROM Has_Treatment
    WHERE Has_Treatment.Treatment_id IN(
        SELECT Treatment.id
        FROM Treatment
        WHERE Treatment.name='Treatment_name'
    )
);

--21--
SELECT DISTINCT Diseases.name
FROM Diseases
WHERE Diseases.id IN(
    SELECT Modes_of_Transmission.Disease_id
    FROM Modes_of_Transmission
    WHERE Modes_of_Transmission.Transmission_id IN(
        SELECT Transmission_modes.id
        FROM Transmission_modes
        WHERE Transmission_modes.name='transmission_name'
    )
);

--22--
SELECT DISTINCT Diseases.name
FROM Diseases
WHERE Diseases.id IN(
    SELECT Has_Vaccine.Disease_id
    FROM Has_Vaccine
    WHERE Has_Vaccine.Vaccine_id IN(
        SELECT Vaccines.id
        FROM Vaccines
        WHERE Vaccines.name='Vaccine_name'
    )
);

--23--
SELECT DISTINCT Diseases.name
FROM Diseases
WHERE Diseases.id IN(
    SELECT Identification_test.Disease_id
    FROM Identification_test
    WHERE Identification_test.test_id IN(
        SELECT Types_of_tests.id
        FROM Types_of_tests
        WHERE Types_of_tests.name='test_name'
    )
);

--24--
SELECT DISTINCT Diseases.name
FROM Diseases
WHERE Diseases.id IN(
    SELECT Has_symptoms.Disease_id
    FROM Has_symptoms
    WHERE Has_symptoms.symptom_id IN (
        SELECT Types_of_symptoms.id
        FROM Types_of_symptoms
        WHERE Types_of_symptoms.name IN :symptom_table
    )
);

--25--
SELECT DISTINCT Diseases.name
FROM Diseases
JOIN Has_symptoms ON Diseases.id = Has_symptoms.Disease_id
JOIN Types_of_symptoms ON Has_symptoms.symptom_id = Types_of_symptoms.id
WHERE Types_of_symptoms.name IN :symptom_table
GROUP BY Diseases.id, Diseases.name
HAVING COUNT(DISTINCT Types_of_symptoms.name) = :num_of_symptoms;


--26--
SELECT Prevention.description 
FROM Prevention
WHERE Prevention.Disease_id IN (
    SELECT Diseases.id 
    FROM Diseases
    WHERE Diseases.name IN (
        SELECT DISTINCT Diseases.name
        FROM Diseases
        WHERE Diseases.id IN(
            SELECT Has_symptoms.Disease_id
            FROM Has_symptoms
            WHERE Has_symptoms.symptom_id IN (
                SELECT Types_of_symptoms.id
                FROM Types_of_symptoms
                WHERE Types_of_symptoms.name IN :symptom_table
    )
)

    )

);

--27--
SELECT Prevention.description 
FROM Prevention
WHERE Prevention.Disease_id IN (
    SELECT Diseases.id 
    FROM Diseases
    WHERE Diseases.name IN (
        SELECT DISTINCT Diseases.name
        FROM Diseases
        JOIN Has_symptoms ON Diseases.id = Has_symptoms.Disease_id
        JOIN Types_of_symptoms ON Has_symptoms.symptom_id = Types_of_symptoms.id
        WHERE Types_of_symptoms.name IN :symptom_table
        GROUP BY Diseases.id, Diseases.name
        HAVING COUNT(DISTINCT Types_of_symptoms.name) = :num_of_symptoms
    )

);

--28--
SELECT DISTINCT ON (Diseases.name) Diseases.name,Diseases.born_country,Diseases.born_year,Diseases.mortality_rate,Types_of_symptoms.name as symptoms_name,Medicine.name as medicine_name,Medicine.prescription as medicine_prescription,Medicine.side_effects as medicine_side_effects,Has_Medicine.Dosage as medicine_dosage,Treatment.name as treatment_name,Treatment.type as treatment_type,Treatment.description as treatment_description,Vaccines.name as Vaccine_name,Types_of_tests.name as test_name,Types_of_tests.description as test_description,Transmission_modes.name as modes_name,Transmission_modes.description as modes_description ,Prevention.description as Prevention
FROM Diseases
JOIN Has_symptoms ON Diseases.id = Has_symptoms.Disease_id
JOIN Types_of_symptoms ON Has_symptoms.symptom_id = Types_of_symptoms.id
JOIN Has_Medicine ON Diseases.id=Has_Medicine.Disease_id
JOIN Medicine ON Has_Medicine.Medicine_id=Medicine.id
JOIN Has_Treatment ON Diseases.id=Has_Treatment.Disease_id
JOIN Treatment ON Has_Treatment.Treatment_id=Treatment.id
JOIN Has_Vaccine ON Diseases.id=Has_Vaccine.Disease_id
JOIN Vaccines ON Has_Vaccine.Vaccine_id=Vaccines.id
JOIN Identification_test ON Diseases.id=Identification_test.Disease_id
JOIN Types_of_tests ON Identification_test.test_id=Types_of_tests.id
JOIN Modes_of_Transmission ON Diseases.id=Modes_of_Transmission.Disease_id
JOIN Transmission_modes ON Modes_of_Transmission.Transmission_id=Transmission_modes.id
JOIN Prevention ON Diseases.id=Prevention.Disease_id
WHERE Diseases.name='disease_name';








