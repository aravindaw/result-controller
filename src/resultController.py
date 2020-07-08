#!/usr/bin/env python3

import os
import logging
import threading
import time
import subprocess
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

logging.basicConfig(filename='/home/result-controller/info.log', filemode='w', level=logging.INFO)
ALLURE_REPORT_DIRECTORY = "/home/allure-report"


class Watcher:

    ALLURE_RESULT_DIRECTORY = "/home/results"

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
            logging.info('Error')

        self.observer.join()


class Handler(FileSystemEventHandler):

    @staticmethod
    def on_any_event(event):
        logging.info(f'event type: {event.event_type}  path : {event.src_path}')
        if event.event_type == 'created':
            logging.info('new content created.')
            Handler.report_generator(event.src_path)
            return
        elif event.event_type == 'moved':
            logging.info('Content modified.')
            Handler.report_generator(event.src_path)
            return

    @staticmethod
    def report_generator(report_path):
        size_past = -1
        print("new file size:::: ")
        # historical_size = -1
        while True:
            size_now = os.path.getsize(report_path)
            if size_now == size_past:
                print("file has copied completely now size: %s", size_now)
                break
            else:
                size_past = os.path.getsize(report_path)
                time.sleep(3)
                print("file copying size: %s", size_past)
        print("file copy has now finished......................")
        print('Execute generator.')
        threads = []
        process = subprocess.Popen(f'sh /home/generator.sh {report_path} {ALLURE_REPORT_DIRECTORY}', shell=True, stdout=subprocess.PIPE).wait()
        thread = threading.Thread(target=process)
        threads.append(thread)
        thread.start()
        # os.system('allure open -p 8080 /home/allure-report/ &')


if __name__ == '__main__':
    w = Watcher()
    w.run()
