#! /usr/bin/env python

from requests import get
from bs4 import BeautifulSoup
from sys import exit

BASE_URL = "https://www.capfriendly.com/teams/"
SAVE_DIR = "downloads"
DOWNLOAD_IS_ON = False
ONE_TEAM_ONLY = False

teams = {
    "lightning": "TBL",
    "capitals": "WAS",
    "blues": "STL",
    "oilers": "EDM",
    "ducks": "ANA",
    "jets": "WPG",
    "canucks": "VAN",
    "canadiens": "MTL",
    "mapleleafs": "TOR",
    "goldenknights": "VGK",
    "flames": "CGY",
    "stars": "DAL",
    "hurricanes": "CAR",
    "penguins": "PIT",
    "avalanche": "COL",
    "coyotes": "ARI",
    "flyers": "PHI",
    "sharks": "SJS",
    "wild": "MIN",
    "bruins": "BOS",
    "sabres": "BUF",
    "islanders": "NYI",
    "blackhawks": "CHI",
    "bluejackets": "CLB",
    "rangers": "NYR",
    "panthers": "FLA",
    "predators": "NAS",
    "redwings": "DET",
    "senators": "OTT",
    "kings": "LAK",
    "devils": "NJD",
    "kraken": "SEA",
}

sections = {
    "skip": [
        "Buried Penalty",
        "Buyout History",
        "Recapture Penalty",
        "Retained Salary",
        "Terminated Penalty",
    ],
    "keep": [
        "Defense",
        "Forwards",
        "Goalies",
        "Long-Term Injured Reserve",
        "NHLPA Player Assistance Program",
        "Professional Tryout",
        "Injured Reserve",
        "Season Opening Injured Reserve",
    ],
}

positions = {
    "Defense": "D",
    "Forwards": "F",
    "Goalies": "G",
    "Long-Term Injured Reserve": "None",
    "NHLPA Player Assistance Program": "None",
    "Professional Tryout": "None",
    "Injured Reserve": "None",
    "Season Opening Injured Reserve": "None",
}

if ONE_TEAM_ONLY:
    teams = {"lightning": "TBL"}

# Download
if DOWNLOAD_IS_ON:
    for team in teams:
        URL = f"{BASE_URL}{team}"
        FILENAME = f"{SAVE_DIR}/{team}.html"
        with open(FILENAME, "wb") as file:
            response = get(URL)
            file.write(response.content)


# import pdb; pdb.set_trace()

# Parse
with open("salary.csv", "w") as output:
    for team in teams:
        print(team)
        FILENAME = f"{SAVE_DIR}/{team}.html"
        PRETTY = f"{SAVE_DIR}/{team}.pretty.html"
        with open(FILENAME, "r") as f:
            contents = f.read()
            soup = BeautifulSoup(contents, "lxml")
            with open(PRETTY, "w") as pretty:
                pretty.write(soup.prettify())

            # OLD
            # table = soup.find('table', id='team')
            # players_c = table.find_all('tr', {'class': ['odd c', 'even c']})

            # NEW
            tables = soup.find_all(
                "table", {"class": "cf_teamProfileRosterSection__table"}
            )
            # tables = soup.find_all('div', {"class": 'cf_teamProfileRosterSection__table_wrapper'})

            for table in tables:
                section_name = table.find("th").text
                # print and comment below then README sed
                # print(section_name)
                # comment below
                skip_section = True
                player_position = None
                for section_name_short in sections["keep"]:
                    if section_name_short in section_name:
                        skip_section = False
                        player_position = positions[section_name_short]
                        break
                if skip_section:
                    continue

                tbody = table.find("tbody")
                players = tbody.find_all("tr")

                for player in players:
                    team_abbr = teams[team]
                    td = player.find_all("td")
                    href = td[0].find("a").get("href")
                    try:
                        cap = td[8].find("span", {"class": "cap"}).text
                    except AttributeError:
                        cap = "0"
                    name = href[9:].replace("-", " ").title()
                    caphit = cap.replace("$", "").replace(",", "")
                    output.write(f"{name};{caphit};{team_abbr};{player_position}\n")
