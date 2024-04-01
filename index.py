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
  env.get_template("golang.yml.j2").stream().dump("./test.yml")
