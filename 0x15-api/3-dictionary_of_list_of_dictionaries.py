#!/usr/bin/python3
"""Gather all user todo list from an API and export to JSON file."""
import json
import requests
from sys import argv

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com"
    out = {}
    for i in range(1, 11):
        user = requests.get("{}/users/{}".format(url, i)).json()
        todo = requests.get("{}/todos?userId={}".format(url, i)).json()
        tasks = []
        for task in todo:
            temp_task = {}
            temp_task["task"] = task["title"]
            temp_task["completed"] = task["completed"]
            temp_task["username"] = user["username"]
            tasks.append(temp_task)
        out[str(i)] = tasks
    with open("todo_all_employees.json", 'w') as jsonfile:
        json.dump(out, jsonfile)
