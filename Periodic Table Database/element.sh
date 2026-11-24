#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Please provide an element as an argument."
    exit 0
fi

INPUT=$(printf "%s" "$1" | sed "s/'/''/g")

RESULT=$(psql -X -q --username=freecodecamp --dbname=periodic_table \
    -t --no-align -F '|' -c "
    SELECT
        e.atomic_number,
        e.name,
        e.symbol,
        t.type,
        p.atomic_mass,
        p.melting_point_celsius,
        p.boiling_point_celsius
    FROM elements e
    JOIN properties p USING (atomic_number)
    JOIN types t USING (type_id)
    WHERE e.atomic_number::TEXT = '$INPUT'
       OR e.symbol = '$INPUT'
       OR e.name = '$INPUT'
    LIMIT 1;
")

if [[ -z "$RESULT" ]]; then
    echo "I could not find that element in the database."
    exit 0
fi

IFS='|' read -r NUMBER NAME SYMBOL TYPE MASS MELTING BOILING <<< "$RESULT"

echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
