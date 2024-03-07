#!/usr/bin/python3

"""Top Ten posts of a subreddit"""

import requests


def top_ten(subreddit):
    """
    Prints the titles of the first 10 hot posts listed for a given subreddit
    """
    url = "https://old.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    headers = {'User-Agent': 'Extra-Ordinary user'}
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code != 200:
        print(None)
        return
    data = response.json().get('data')
    children = data.get('children')
    for child in children:
        print(child.get('data').get('title'))
