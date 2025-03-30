#!/bin/bash
# File                : 26m.sh 
# Creation DateTime   : 48_Sun_20231203-01_57_21
# Last Updated Date   : 29_Mon_2024Jul15-08_50_50
# Latest Update       : 30_Sun_2025Mar30
# Author              : Sunil Choudhary 
# Remarks             : Improved pomodoro with 48min work / 12min break cycles

# ===== Configuration =====
WORK_SEGMENT=720       # 12 minutes in seconds
BREAK_DURATION=720     # 12 minutes in seconds
SEGMENTS_PER_CYCLE=4   # 4 segments = 48 minutes total work time
NEXT_ACTION_FILE="NextAction.md"
SOUND_DIR="${HOME}/Music"
LOG_FILE="pomodoro_log.txt"

# ===== Sound Files =====
WORK_SEGMENT_SOUND="${SOUND_DIR}/12.mp3"
WORK_COMPLETE_SOUND="${SOUND_DIR}/48.mp3"
BREAK_START_SOUND="${SOUND_DIR}/Nescafe.mp3"
BREAK_END_SOUND="${SOUND_DIR}/Nescafe.mp3"
HOUR_MARK_SOUND="${SOUND_DIR}/ShortBeep.mp3"

# ===== Colors =====
RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
ORANGE="\033[0;33m"
LGRAY="\033[0;37m"
DGRAY="\033[1;30m"
LBLUE="\033[1;34m"
LGREEN="\033[1;32m"
LCYAN="\033[1;36m"
LRED="\033[1;31m"
NC='\033[0m' # No Color

# ===== Functions =====

# Sound playing function with error handling
play_sound() {
    if [ -f "$1" ]; then
        mpg123 -q "$1" || echo "Failed to play sound: $1"
    else
        echo -e "${YELLOW}Warning: Sound file not found: $1${NC}"
    fi
}

# Desktop notification function with error handling
send_notification() {
    local urgency="$1"
    local message="$2"
    DISPLAY=:0 notify-send -u "$urgency" "$message" >/dev/null 2>&1 || 
        echo "Failed to send notification: $message"
}

# Format time for display
format_time() {
    date --date "+$1 mins" +"%H:%M"
}

# Log activity to file
log_activity() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Ask for intention/task
ask_intention() {
    echo -e "${LGREEN}=== New Pomodoro Cycle ===${NC}"
    read -p "What is your intention for this 48-minute cycle (use b/B for immediate break)? " intention
    
    if [[ -n "$intention" ]]; then
        echo "$(date +'%Y-%m-%d %H:%M') - $intention" >> "$NEXT_ACTION_FILE"
        log_activity "Starting new cycle: $intention"
        echo -e "${LGREEN}Intention saved to $NEXT_ACTION_FILE${NC}"
    fi
}

# Show recent tasks from NextAction.md
show_recent_tasks() {
    if [ -f "$NEXT_ACTION_FILE" ]; then
        echo -e "${LCYAN}Recent tasks:${NC}"
        tail -n 5 "$NEXT_ACTION_FILE" | cat -n
        echo ""
    fi
}

# Work segment function (12 minutes)
work_segment() {
    local segment_num="$1"
    local segment_end=$(format_time 12)
    
    echo -e "${GREEN}Work segment $segment_num/4 started - ends at $segment_end ${NC}"
    send_notification "low" "Work segment $segment_num/4 started - ends at $segment_end"
    play_sound "$WORK_SEGMENT_SOUND"
    
    # Timer with break check
    local elapsed=0
    local check_interval=5  # Check every 5 seconds
    
    while [ $elapsed -lt $WORK_SEGMENT ]; do
        read -t $check_interval -N 1 input
        elapsed=$((elapsed + check_interval))
        
        if [[ $input = "b" ]] || [[ $input = "B" ]]; then
            echo -e "${YELLOW}Unplanned break started at $(date +"%H:%M")${NC}"
            log_activity "Unplanned break started"
            send_notification "critical" "Unplanned break started"
            play_sound "$BREAK_START_SOUND"
            
            sleep $BREAK_DURATION
            
            echo -e "${YELLOW}Unplanned break ended${NC}"
            log_activity "Unplanned break ended"
            send_notification "critical" "Unplanned break ended"
            play_sound "$BREAK_END_SOUND"
            
            # Reset time for this segment
            elapsed=0
            echo -e "${GREEN}Resuming work segment $segment_num/4${NC}"
        fi
    done
}

# Scheduled break function
scheduled_break() {
    local break_end=$(format_time 12)
    echo -e "${ORANGE}Break started - ends at $break_end${NC}"
    log_activity "Scheduled break started"
    send_notification "critical" "Break started - ends at $break_end"
    play_sound "$BREAK_START_SOUND"
    
    sleep $BREAK_DURATION
    
    echo -e "${ORANGE}Break ended${NC}"
    log_activity "Scheduled break ended"
    send_notification "critical" "Break ended"
    play_sound "$BREAK_END_SOUND"
}

# Complete work cycle notification
complete_cycle() {
    echo -e "${RED}48-minute work cycle completed at $(date +"%H:%M")${NC}"
    log_activity "48-minute work cycle completed"
    send_notification "critical" "48-minute work cycle completed!"
    play_sound "$WORK_COMPLETE_SOUND"
}

# Hour marker
hour_marker() {
    echo -e "${LBLUE}Full 60-minute cycle completed at $(date +"%H:%M")${NC}"
    log_activity "Full 60-minute cycle completed"
    send_notification "normal" "Full 60-minute cycle completed"
    play_sound "$HOUR_MARK_SOUND"
}

# Display help
show_help() {
    echo -e "${LCYAN}=== 48/12 Pomodoro Timer Help ===${NC}"
    echo -e "This script runs a modified Pomodoro timer with 48-minute work periods (4x12min) and 12-minute breaks."
    echo -e "Controls:"
    echo -e "  Press ${LGREEN}b${NC} or ${LGREEN}B${NC} during a work segment to take an unplanned break"
    echo -e "  Press ${LGREEN}q${NC} or ${LGREEN}Q${NC} to quit the program"
    echo -e "  Press ${LGREEN}h${NC} or ${LGREEN}H${NC} to show this help message"
    echo -e "  Press ${LGREEN}s${NC} or ${LGREEN}S${NC} to skip the current segment"
    echo -e "Activities are logged to ${LGREEN}$LOG_FILE${NC}"
    echo -e "Intentions are saved to ${LGREEN}$NEXT_ACTION_FILE${NC}"
    echo
}

# ===== Main Program =====

# Create necessary files
touch "$NEXT_ACTION_FILE"
touch "$LOG_FILE"

# Display initial information
echo -e "${LGREEN}=== 48/12 Pomodoro Timer ===${NC}"
echo -e "${LGREEN}Created by Sunil Choudhary, enhanced version${NC}"
echo -e "${ORANGE}Press h or H for help${NC}"
echo

show_recent_tasks
ask_intention

# Main loop
while true; do
    # Check for quit command before starting cycle
    read -t 0.25 -N 1 input
    if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
        echo -e "${YELLOW}Exiting Pomodoro timer.${NC}"
        log_activity "Program exited by user"
        exit 0
    elif [[ $input = "h" ]] || [[ $input = "H" ]]; then
        show_help
    fi
    
    # Complete work cycle (4 segments of 12 minutes each)
    for segment in $(seq 1 $SEGMENTS_PER_CYCLE); do
        work_segment $segment
    done
    
    # Work cycle complete notification
    complete_cycle
    
    # Scheduled break
    scheduled_break
    
    # Hour marker (after 48min work + 12min break = 60min)
    hour_marker
    
    # Ask for the next intention
    show_recent_tasks
    ask_intention
done
