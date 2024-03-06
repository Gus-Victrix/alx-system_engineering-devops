#!/usr/bin/python3

"""
Print sorted count of given keywords
"""

import requests


def count_words(subreddit, word_list, dictWord={}, after=None):
    """
    Recursive function that queries the Reddit API, parses the title
    of all hot articles, and prints a sorted count of given keywords
    (case-insensitive, delimited by spaces. Javascript should count as
    javascript, but java should not)
    """
    headers = {'User-Agent': 'Mozilla/5.0'}
    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    params = {'limit': 100, 'after': after}
    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)

    if response.status_code != 200:
        return None

    data = response.json().get('data')
    after = data.get('after')
    children = data.get('children')

    for child in children:
        title = child.get('data').get('title').lower().split()
        for word in word_list:
            if word.lower() in title:
                if word in dictWord:
                    dictWord[word] += 1
                else:
                    dictWord[word] = 1

    if after:
        return count_words(subreddit, word_list, dictWord, after)
    else:
        if len(dictWord) == 0:
            return None
        for key, value in sorted(dictWord.items(),
                                 key=lambda x: (-x[1], x[0])):
            print('{}: {}'.format(key, value))
