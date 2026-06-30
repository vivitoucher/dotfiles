#!/usr/bin/env python3
import datetime
import sys

def get_poetic_time():
    now = datetime.datetime.now()
    hour = now.hour
    minute = now.minute
    day_name = now.strftime("%A").lower()

    # define time periods
    if 5 <= hour < 12:
        period = "morning"
    elif 12 <= hour < 17:
        period = "afternoon"
    elif 17 <= hour < 21:
        period = "evening"
    else:
        period = "night"

    # build conversational descriptors
    if minute == 0:
        modifier = f"exactly the start of a {day_name}"
    elif minute < 15:
        modifier = f"the early moments of a {day_name}"
    elif 15 <= minute < 45:
        modifier = f"deep into a fluid {day_name}"
    else:
        modifier = f"the drifting tail of a {day_name}"

    # compile the final string
    return f"it is {modifier} {period}."

if __name__ == "__main__":
    # print the string clean so quickshell can capture it
    sys.stdout.write(get_poetic_time())
