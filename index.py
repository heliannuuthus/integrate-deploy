import json
import os

from jinja2 import Environment, FileSystemLoader, select_autoescape

env = Environment(
  loader=FileSystemLoader("templates"),
  autoescape=select_autoescape(),
  enable_async=True,
  trim_blocks=True,
  lstrip_blocks=True,
  keep_trailing_newline=True,

)

if __name__ == '__main__':
  directory = "templates"
  for item in os.listdir(directory):
    full_path = os.path.join(directory, item)
    if os.path.isdir(full_path):
      with open(f"{directory}/{item}/data.json") as f:
        env.get_template(f"{item}/index.j2").stream(data=json.load(f)).dump(f".github/workflows/call-{item}.yml")
