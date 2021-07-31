# shellcheck disable=SC2164

# cd app/
rasa run actions --actions actions&
rasa run --model models --enable-api \
        --endpoints /app/endpoints.yml \
        --cors "*" \
        -p $PORT