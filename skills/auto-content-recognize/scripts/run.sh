        #!/usr/bin/env bash
        # public API source
        set -euo pipefail

        MODE=""
        TOKEN="${CONTENT_RECOGNIZE_TOKEN:-yt-research-token-2026}"
        ENDPOINT_OVERRIDE=""
        URL=""
SCREENSHOT_URL=""
FILE=""


        for arg in "$@"; do
          case "$arg" in
            --mode=*) MODE="${arg#--mode=}" ;;
            --token=*) TOKEN="${arg#--token=}" ;;
            --endpoint=*) ENDPOINT_OVERRIDE="${arg#--endpoint=}" ;;

                --url=*) URL="${arg#--url=}" ;;
        --screenshot-url=*) SCREENSHOT_URL="${arg#--screenshot-url=}" ;;
        --file=*) FILE="${arg#--file=}" ;;
            -h|--help)
              echo "Usage: $0 --mode=<mode> [--token=TOKEN] [--endpoint=URL]"
              exit 0
              ;;
          esac
        done

        if [[ -z "$MODE" ]] && [[ -n "$URL" ]]; then
  MODE="url"
fi
if [[ -z "$MODE" ]] && [[ -n "$SCREENSHOT_URL" ]]; then
  MODE="screenshot-url"
fi
if [[ -z "$MODE" ]] && [[ -n "$FILE" ]]; then
  MODE="file"
fi

        if [[ -z "$MODE" ]]; then
          echo "Provide --mode or enough fields to infer one" >&2
          exit 1
        fi

        TOKEN="${TOKEN#Bearer }"
        TOKEN="${TOKEN#bearer }"



        ENDPOINT=https://image-recognize.hb67egcim4.workers.dev
        if [[ -n "$ENDPOINT_OVERRIDE" ]]; then
          ENDPOINT="$ENDPOINT_OVERRIDE"
        fi

        COMMON_HEADERS=()
        if [[ -n "$TOKEN" ]]; then
          COMMON_HEADERS+=(-H "Authorization: Bearer $TOKEN")
        fi

        case "$MODE" in
                        url)
                PAYLOAD=$(URL="${URL}" python3 -c 'import json, os; keys = ["url"]; data = {}; [data.__setitem__(key, os.environ.get(key.upper().replace("-", "_").replace(".", "_")) or os.environ.get(key.upper().replace("-", "_"))) for key in keys if (os.environ.get(key.upper().replace("-", "_").replace(".", "_")) or os.environ.get(key.upper().replace("-", "_")))]; print(json.dumps(data))')
curl --fail-with-body -sS -L "$ENDPOINT" "${COMMON_HEADERS[@]}" -H "Content-Type: application/json" -d "$PAYLOAD"
                  ;;
                screenshot-url)
                PAYLOAD=$(SCREENSHOT_URL="${SCREENSHOT_URL}" python3 -c 'import json, os; keys = ["screenshot_url"]; data = {}; [data.__setitem__(key, os.environ.get(key.upper().replace("-", "_").replace(".", "_")) or os.environ.get(key.upper().replace("-", "_"))) for key in keys if (os.environ.get(key.upper().replace("-", "_").replace(".", "_")) or os.environ.get(key.upper().replace("-", "_")))]; print(json.dumps(data))')
curl --fail-with-body -sS -L "$ENDPOINT" "${COMMON_HEADERS[@]}" -H "Content-Type: application/json" -d "$PAYLOAD"
                  ;;
            file)
            curl --fail-with-body -sS -L "$ENDPOINT" "${COMMON_HEADERS[@]}" \
-F "file=@${FILE}" \
| cat
              ;;
          *)
            echo "Unsupported mode: $MODE" >&2
            exit 1
            ;;
        esac
