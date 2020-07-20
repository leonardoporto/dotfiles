#!/usr/bin/env python
import os
import math
from threading import Thread
from pydbus import SessionBus
import click
import time

bus = SessionBus()


def get_notification_proxy():
    return bus.get(
        "org.freedesktop.Notifications", "/org/freedesktop/Notifications")


def get_pomodoro_proxy():
    return bus.get("org.gnome.Pomodoro", "/org/gnome/Pomodoro")


def format_time(seconds):
    return "{minutes:02d}:{seconds:02d}".format(
        minutes=int(math.floor(seconds / 60)),
        seconds=int(round(seconds % 60))
    )


def format_is_paused(is_paused):
    return "PAUSED " if is_paused else ""


def format_state(state):
    return {
        "pomodoro": "",
        "short-break": "Break",
        "long-break": "Long Break",
    }[state]


def extract_pomodoro_data(pomodoro):
    return {
        "elapsed": pomodoro.Elapsed, 
        "is_paused": pomodoro.IsPaused,
        "duration": pomodoro.StateDuration,
        "remaining": pomodoro.StateDuration - pomodoro.Elapsed,
        "state": pomodoro.State
    }


def format_pomodoro_data(pomodoro_data):
    return {
        "elapsed": format_time(pomodoro_data["elapsed"]),
        "duration": format_time(pomodoro_data["duration"]),
        "remaining": format_time(pomodoro_data["remaining"]),
        "is_paused": format_is_paused(pomodoro_data["is_paused"]),
        "state": format_state(pomodoro_data["state"]),
    }


def format_output(pomodoro_data):
    if pomodoro_data["state"] != "null":
        return "{state} {remaining} {is_paused}".format(**format_pomodoro_data(pomodoro_data))
    else:
        return "Off"


def file_output(text):
    script_dir = os.path.dirname(__file__)
    file_path = os.path.join(script_dir, 'status')
    with open(file_path, 'w') as status:
        status.write(text)


def refresh_status():
    pomodoro = get_pomodoro_proxy()
    while 1:
        pomodoro_data = extract_pomodoro_data(pomodoro)
        file_output(format_output(pomodoro_data))
        time.sleep(1)


@click.group()
def main():
    pass


@click.command()
def status():
    pomodoro = get_pomodoro_proxy()
    pomodoro_data = extract_pomodoro_data(pomodoro)
    click.echo(format_output(pomodoro_data))


@click.command()
def pause():
    get_pomodoro_proxy().Pause()


@click.command()
def resume():
    get_pomodoro_proxy().Resume()


@click.command()
def start():
    get_pomodoro_proxy().Start()


@click.command()
def stop():
    get_pomodoro_proxy().Stop()


@click.command()
def skip():
    get_pomodoro_proxy().Skip()


@click.command()
def reset():
    get_pomodoro_proxy().Reset()


@click.command()
def toggle():
    pomodoro = get_pomodoro_proxy()
    if pomodoro.IsPaused:
        pomodoro.Resume()
    else:
        pomodoro.Pause()
@click.command()
def daemon():
    daemon_commands = [refresh_status()]
    threads = [Thread(target=command) for command in daemon_commands]
    for thread in threads:
        thread.daemon = True
        thread.start()

    for thread in threads:
        thread.join()


main.add_command(status)
main.add_command(pause)
main.add_command(resume)
main.add_command(start)
main.add_command(stop)
main.add_command(skip)
main.add_command(reset)
main.add_command(toggle)
main.add_command(daemon)

if __name__ == "__main__":
    main()

