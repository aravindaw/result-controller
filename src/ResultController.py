#!/usr/bin/env python3

import errno
import os
import time
import subprocess
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler


class Watcher:
    ALLURE_RESULT_DIRECTORY = "/home/allure-results"

    def __init__(self):
        self.observer = Observer()

    def run(self):
        event_handler = Handler()
        self.observer.schedule(event_handler, self.ALLURE_RESULT_DIRECTORY, recursive=False)
        self.observer.start()
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            self.observer.stop()
            print("Error")

        self.observer.join()


class Handler(FileSystemEventHandler):

    @staticmethod
    def on_any_event(event):
        print(f'event type: {event.event_type}  path : {event.src_path}')
        if event.event_type == 'created':
            print('new content created.')
            Handler.report_generator()
            return
        elif event.event_type == 'moved':
            print('Content modified.')
            Handler.report_generator()
            return

    @staticmethod
    def report_generator():
        process = subprocess.Popen("allure ", shell=True, stdout=subprocess.PIPE)
        process.wait()


if __name__ == '__main__':
    w = Watcher()
    w.run()
