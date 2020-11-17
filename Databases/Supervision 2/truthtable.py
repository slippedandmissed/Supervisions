#!/usr/bin/python3.7
import os

def query(name, val):
    return f"('{name}', CAST({val} AS VARCHAR(255)))"

def enumerate(options, n):
    if n == 0:
        return []
    if n == 1:
        return list([i] for i in options)
    all_options = []
    for i in options:
        all_options += list([i] + x for x in enumerate(options, n-1))
    return all_options

def wrap_in_select(options):
    return list(f"(SELECT value FROM logic WHERE name='v{i}')" for i in options)

def truth_table(expr, options, n):
    return "SELECT C1 as expression, C2 as value FROM (VALUES" + ", ".join(query(expr.format(*i), expr.format(*wrap_in_select(i))) for i in enumerate(options, n)) + ");"

def view(options):
    return "CREATE VIEW logic AS SELECT C1 AS name, C2 AS value FROM (VALUES{});".format(", ".join(f"('v{i}', {i})" for i in options))

def print_command(expr, n, options=["true", "false", "null"]):
    print(view(options)+truth_table(expr, options, n))

print_command("{} AND {}", 2)