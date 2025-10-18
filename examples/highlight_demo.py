#!/usr/bin/env python3
"""
This file demonstrates the auto-highlighting feature of vim-todo-navigator.

When you open this file in Vim with the plugin enabled, all TODO keywords
will be automatically highlighted with different colors!
"""

def calculate_sum(a, b):
    # TODO: Add input validation
    return a + b


def process_data(data):
    # FIXME: This function is too slow for large datasets
    result = []
    for item in data:
        # NOTE: We need to handle None values here
        if item is not None:
            result.append(item * 2)
    return result


def parse_config(config_file):
    # HACK: Temporary workaround until we implement proper config parser
    with open(config_file, 'r') as f:
        return eval(f.read())  # XXX: This is dangerous! Use json.load instead


def legacy_function():
    # CANCELLED: This feature was removed in v2.0
    pass


class DataProcessor:
    def __init__(self):
        self.data = []
        # BUG: Memory leak when processing large files
        self.cache = {}
    
    def process(self, item):
        # TODO: Implement caching mechanism
        # FIXME: Handle edge cases
        return item.upper()


if __name__ == "__main__":
    # NOTE: Remember to test with different input types
    print(calculate_sum(5, 3))
    
    # TODO: Add command-line argument parsing
    # FIXME: Error handling needed here
    data = [1, 2, None, 4, 5]
    print(process_data(data))
