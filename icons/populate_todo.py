from tabulate import tabulate
import requests

# table headers
data = [
    ["Name", "Calibre Default", "CTP Latte", "CTP Frappe", "CTP Macchiato", "CTP Mocha"]
]

url = "https://api.github.com/repos/kovidgoyal/calibre/contents/imgsrc"

response = requests.get(url)

if response.status_code == 200:
    files = response.json()

    for file in files:
        if not file["name"].endswith(".svg"):
            continue
        # print(file["name"])        
        data.append([
            file["name"].rstrip(".svg"),
            f"<img src='https://raw.githubusercontent.com/kovidgoyal/calibre/master/imgsrc/{file["name"]}' width='100' alt='calibre'>",
            f"<img src='https://raw.githubusercontent.com/catppuccin/calibre/master/icons/src/latte/{file["name"]}' width='100' alt='latte'>",
            f"<img src='https://raw.githubusercontent.com/catppuccin/calibre/master/icons/src/frappe/{file["name"]}' width='100' alt='frappe'>",
            f"<img src='https://raw.githubusercontent.com/catppuccin/calibre/master/icons/src/macchiato/{file["name"]}' width='100' alt='macchiato'>",
            f"<img src='https://raw.githubusercontent.com/catppuccin/calibre/master/icons/src/mocha/{file["name"]}' width='100' alt='mocha'>"
        ])
else:
    print(f"Failed to get files: {response.status_code}")

# generate the Markdown table
markdown_table = tabulate(data, headers="firstrow", tablefmt="pipe")

print(markdown_table)

# save to output directory
with open("output.md", "w") as f:
    f.write(markdown_table)