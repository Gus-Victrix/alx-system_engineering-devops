#!/usr/bin/python3

"""
Uses the Reddit API to get the number of subscribers for a given subreddit
"""

import requests


def number_of_subscribers(subreddit):
    """
    Queries the Reddit API and returns the number of subscribers for a given
    subreddit
    """
    url = "https://old.reddit.com/r/{}/about.json".format(subreddit)
    headers = {"User-Agent": "Non Ordinary User"}
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code != 200:
        return 0
    return response.json().get("data").get("subscribers")
