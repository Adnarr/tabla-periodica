#!/usr/bin/env bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

INPUT="$1"

if [[ -z "$INPUT" ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi

# Detectar tipo de input
if [[ "$INPUT" =~ ^[0-9]+$ ]]; then
  COND="e.atomic_number = $INPUT"
elif [[ "$INPUT" =~ ^[A-Za-z]{1,2}$ ]]; then
  COND="e.symbol = INITCAP('$INPUT')"
else
  COND="e.name = INITCAP('$INPUT')"
fi

QUERY="
SELECT e.atomic_number,
       e.name,
       e.symbol,
       p.atomic_mass,
       p.melting_point_celsius,
       p.boiling_point_celsius,
       t.type
FROM elements e
JOIN properties p USING(atomic_number)
JOIN types t USING(type_id)
WHERE $COND
"

RESULT="$($PSQL "$QUERY")"

if [[ -z "$RESULT" ]]; then
  echo "I could not find that element in the database."
  exit 0
fi

IFS="|" read -r A_NUM NAM SYM MASS MP BP TYP <<< "$RESULT"
echo "The element with atomic number $A_NUM is $NAM ($SYM). It's a $TYP, with a mass of $MASS amu. $NAM has a melting point of $MP celsius and a boiling point of $BP celsius."
