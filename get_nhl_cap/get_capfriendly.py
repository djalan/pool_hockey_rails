#! /usr/bin/env python

from requests import get
from bs4 import BeautifulSoup
from sys import exit
import os

BASE_URL = "https://www.capfriendly.com/teams/"
SAVE_DIR = "downloads"
DOWNLOAD_IS_ON = False
ONE_TEAM_ONLY = False

DIR_NAME_OF_THIS_FILE = os.path.dirname(os.path.realpath(__file__))

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
        FILENAME = f"{DIR_NAME_OF_THIS_FILE}/{SAVE_DIR}/{team}.html"
        with open(FILENAME, "wb") as file:
            response = get(URL)
            file.write(response.content)


CURRENT_YEAR_CAP_POSITION = 8
NEXT_YEAR_CAP_POSITION = 9
NAME_START_POSITION_AFTER_BASE_URL = 9
# Parse
with open(f"{DIR_NAME_OF_THIS_FILE}/salary.csv", "w") as output:
    for team in teams:
        print(team)
        FILENAME = f"{DIR_NAME_OF_THIS_FILE}/{SAVE_DIR}/{team}.html"
        PRETTY = f"{DIR_NAME_OF_THIS_FILE}/{SAVE_DIR}/{team}.pretty.html"
        with open(FILENAME, "r") as f:
            contents = f.read()
            soup = BeautifulSoup(contents, "lxml")
            with open(PRETTY, "w") as pretty:
                pretty.write(soup.prettify())

            tables = soup.find_all(
                "table", {"class": "cf_teamProfileRosterSection__table"}
            )

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
                        cap = (
                            td[NEXT_YEAR_CAP_POSITION]
                            .find("span", {"class": "cap"})
                            .text
                        )
                    except AttributeError:
                        cap = "0"
                    name = (
                        href[NAME_START_POSITION_AFTER_BASE_URL:]
                        .replace("-", " ")
                        .title()
                    )
                    caphit = cap.replace("$", "").replace(",", "")
                    output.write(f"{name};{caphit};{team_abbr};{player_position}\n")
