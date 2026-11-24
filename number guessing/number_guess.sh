#!/bin/bash

PSQL="psql -X -q --username=freecodecamp --dbname=number_guess -t --no-align"

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

echo "Enter your username:"
read USERNAME

USERNAME_ESCAPED=$(printf "%s" "$USERNAME" | sed "s/'/''/g")

USER_INFO=$($PSQL -F '|' -c "
SELECT
    users.user_id,
    users.username,
    COUNT(games.game_id),
    COALESCE(MIN(games.number_of_guesses), 0)
FROM users
LEFT JOIN games USING(user_id)
WHERE users.username = '$USERNAME_ESCAPED'
GROUP BY users.user_id, users.username;
")

if [[ -z "$USER_INFO" ]]; then
    USER_ID=$($PSQL -c "
        INSERT INTO users(username)
        VALUES ('$USERNAME_ESCAPED')
        RETURNING user_id;
    ")

    USER_ID=$(echo "$USER_ID" | xargs)

    echo "Welcome, $USERNAME! It looks like this is your first time here."
else
    IFS='|' read -r USER_ID DB_USERNAME GAMES_PLAYED BEST_GAME <<< "$USER_INFO"

    echo "Welcome back, $DB_USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo "Guess the secret number between 1 and 1000:"

while true; do
    read GUESSED_NUMBER

    if ! [[ "$GUESSED_NUMBER" =~ ^[0-9]+$ ]]; then
        echo "That is not an integer, guess again:"
        continue
    fi

    GUESS=$((10#$GUESSED_NUMBER))
    NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))

    if (( GUESS < SECRET_NUMBER )); then
        echo "It's higher than that, guess again:"
    elif (( GUESS > SECRET_NUMBER )); then
        echo "It's lower than that, guess again:"
    else
        echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
        break
    fi
done

$PSQL -c "
INSERT INTO games(user_id, number_of_guesses)
VALUES ($USER_ID, $NUMBER_OF_GUESSES);
"
