#!/usr/bin/python3

"""
Python file 0x16 - API Advenced
"""

import requests


def recurse(subreddit, hot_list=[], after=None):
    """
    Recursive function that queries the Reddit API and returns
    a list containing the titles of all hot articles for a given
    subreddit. If no results are found for the given subreddit,
    the function should return None
    """
    if subreddit is None:
        print(None)
    URL = 'http://www.reddit.com/r/{}/hot.json'.format(subreddit)
    headers = {
        'User-Agent': 'Holberton User Agent 1.0',
        'From': 'mickael.boillaud@gmail.com',
    }
    response = requests.get(
        URL,
        headers=headers,
        params={'after': after}
    )
    if response.status_code == 404:
        return None
    data = response.json()
    allHot = data.get("data", {}).get("children", None)
    after = data.get("data", {}).get("after", None)
    if allHot is None or len(allHot) <= 0 or allHot[0].get('kind') != 't3':
        if len(hot_list) > 0:
            return hot_list
        return None
    for title in allHot:
        hot_list.append(title.get("data", {}).get("title", ""))
    if after is None:
        if len(hot_list) > 0:
            return hot_list
        return None
    return recurse(subreddit, hot_list, after)
