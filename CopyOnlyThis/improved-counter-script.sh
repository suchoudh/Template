#!/bin/bash
#
# myCounter.sh - Time tracking and productivity tool
# Author: Sunil Choudhary (original)
# Last Updated: 2025-03-30
#
# Description: 
#   Helps track time spent on tasks against estimated time.
#   Shows countdown with percentage of time remaining and provides visual feedback.
#   Logs time usage for later review.
#
# Usage:
#   ./myCounter.sh [MINUTES] [TASK_DESCRIPTION]
#   MINUTES defaults to 6 if not provided
#   TASK_DESCRIPTION defaults to "Break" if not provided
#
# Examples:
#   ./myCounter.sh 12 "Write documentation"
#   ./myCounter.sh 30 "Code review"
#   ./myCounter.sh      (will use defaults: 6 minutes for "Break")

# =================== CONFIGURATION ===================

# Define log file locations
LOG_DIR="$HOME/logs"
DAILY_LOG_DIR="$HOME/Desktop/Doday"
mkdir -p "$LOG_DIR" "$DAILY_LOG_DIR"

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Sound file for notifications
SOUND_FILE="$HOME/Music/ShortBeep.mp3"

# =================== FUNCTIONS ===================

# Display help message
show_help() {
  echo "Usage: $(basename "$0") [MINUTES] [TASK_DESCRIPTION]"
  echo
  echo "Options:"
  echo "  MINUTES           Time in minutes (default: 6)"
  echo "  TASK_DESCRIPTION  Description of the task (default: Break)"
  echo
  echo "Examples:"
  echo "  $(basename "$0") 12 \"Write documentation\""
  echo "  $(basename "$0") 30 \"Code review\""
  echo "  $(basename "$0") (will use defaults: 6 minutes for \"Break\")"
  exit 0
}

# Play notification sound
play_notification() {
  if command -v mpg123 >/dev/null && [ -f "$SOUND_FILE" ]; then
    mpg123 -q "$SOUND_FILE" &
  else
    echo -e "\a" # Terminal bell as fallback
  fi
}

# Log a message to all log files
log_message() {
  local message="$1"
  local current_dir="$(pwd)"
  local week_output="$(date +%W_%a_%Y-%m)"
  
  echo "$message" > "$TMP_LOG"
  
  # Append to all logs
  cat "$TMP_LOG" >> "$current_dir/forecastWk$week_output.log"
  [ -d "$LOG_DIR" ] && cat "$TMP_LOG" >> "$LOG_DIR/forecast.log"
  [ -d "$DAILY_LOG_DIR" ] && cat "$TMP_LOG" >> "$DAILY_LOG_DIR/DoDayforecastWk$week_output.log"
  
  # Add location info
  echo "$current_dir" >> "$current_dir/forecastWk$week_output.log"
  [ -d "$LOG_DIR" ] && echo "$current_dir" >> "$LOG_DIR/forecast.log"
  [ -d "$DAILY_LOG_DIR" ] && echo "$current_dir" >> "$DAILY_LOG_DIR/DoDayforecastWk$week_output.log"
}

# =================== MAIN SCRIPT ===================

# Check for help request
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  show_help
fi

# Create NextAction.md if it doesn't exist
touch NextAction.md

# Process arguments with defaults
PREDICTED="${1:-6}"
TASK_NOTE="${2:-Break}"

# Convert minutes to seconds
TOTAL_SECONDS=$((PREDICTED * 60))
TIME_LEFT_SEC=$TOTAL_SECONDS
ELAPSED=0

# Create temporary log file
TMP_LOG="$(mktemp)"
trap 'rm -f "$TMP_LOG"' EXIT

# Display initial information
current_dir="$(pwd)"
echo "Working in: $current_dir"
echo "Task: $TASK_NOTE"
echo "Allocated time: $PREDICTED minutes"
echo "Press q/Q to quit"
echo

# Main countdown loop
while true; do
  # Calculate time metrics
  ELAPSED=$((ELAPSED + 1))
  TIME_LEFT_SEC=$((TOTAL_SECONDS - ELAPSED))
  
  # Calculate percentage with decimal
  if command -v bc >/dev/null; then
    PERCENTAGE=$(bc <<<"scale=1;($TIME_LEFT_SEC*100)/$TOTAL_SECONDS")
  else
    PERCENTAGE=$((TIME_LEFT_SEC * 100 / TOTAL_SECONDS))
  fi
  
  # Display status based on time remaining
  current_time="$(date '+%H:%M:%S')"
  
  if [ $TIME_LEFT_SEC -lt -60 ]; then
    # Over time by more than a minute
    over_percentage=$(bc <<<"scale=1;((-$TIME_LEFT_SEC)*100)/$TOTAL_SECONDS")
    message="${YELLOW}Countdown: $TIME_LEFT_SEC sec :: $over_percentage% Extra Time Used from Allocated $PREDICTED minutes for \"$TASK_NOTE\" :: $current_time${NC}"
    echo -e "$message"
    log_message "$message"
    
  elif [ $TIME_LEFT_SEC -gt 60 ]; then
    # More than a minute remaining
    message="${GREEN}Countdown: $TIME_LEFT_SEC sec :: $PERCENTAGE% of Time Left from Allocated $PREDICTED minutes for \"$TASK_NOTE\" :: $current_time${NC}"
    echo -e "$message"
    log_message "$message"
    
    # Sound notification every 6 minutes if configured
    if [ $((TIME_LEFT_SEC % 360)) -eq 0 ] && [ $TIME_LEFT_SEC -ne $TOTAL_SECONDS ]; then
      play_notification
      next_ping=$(date --date "+6 mins" +"%H:%M")
      echo -e "${GREEN}Next 6-minute mark: $next_ping${NC}"
    fi
    
  else
    # Last minute
    message="${PURPLE}Countdown: $TIME_LEFT_SEC sec :: Last minute of Allocated $PREDICTED minutes for \"$TASK_NOTE\" :: $current_time${NC}"
    echo -e "$message"
    log_message "$message"
    play_notification
  fi
  
  # Check for quit command with timeout
  read -t 0.25 -N 1 input
  if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
    echo
    echo "--- Task ended at $(date) ---"
    log_message "--- Task ended at $(date) ---"
    break
  fi
  
  # Wait for next second
  sleep 1
done

exit 0
