from dataclasses import dataclass
import sys
from pathlib import Path

sys.path.append(Path(__file__).parent.parent.as_posix())

# from extract import Fields, teams
# from get import get_all_skaters
# from definitions import DATA_DIR
from datetime import datetime
import json
from playwright.sync_api import sync_playwright


@dataclass
class Fields:
    player_url = "p_url"
    first_name = "p_fn"
    last_name = "p_ln"
    age = "age"
    position = "pos"
    draft_pos = "dft_p"
    draft_year = "dft_y"
    team_id = "team_id"
    contract_year_left = "yr_left"
    cap_hit = "cap_hit"
    games_played = "st_gp"
    goals = "st_g"
    assists = "st_a"
    points = "st_p"
    # dff = "st_dff"
    reldff = "st_reldff"
    g60 = "st_g60"
    p60 = "st_p60"
    wins = "st_w"
    shutouts = "st_so"


teams = {
    25: "ANA",
    3: "BOS",
    10: "BUF",
    5: "CAR",
    18: "CGY",
    22: "CHI",
    30: "CLB",
    1: "COL",
    20: "DAL",
    2: "DET",
    24: "EDM",
    14: "FLA",
    23: "LAK",
    29: "MIN",
    11: "MTL",
    27: "NAS",
    13: "NJD",
    4: "NYI",
    6: "NYR",
    9: "OTT",
    12: "PHI",
    7: "PIT",
    271: "SEA",
    21: "SJS",
    16: "STL",
    17: "TBL",
    8: "TOR",
    19: "UTA",
    26: "VAN",
    269: "VGK",
    15: "WAS",
    28: "WPG",
    -666: "NA",
}

# all = get_all_skaters()


# with open(DATA_DIR / "total.json", mode="w") as f:
#     f.write("hello")


WORKING_DIR = Path(__file__).parent

SKATERS_JSON = WORKING_DIR / "skaters_2024-2025.json"
SKATERS_CSV = WORKING_DIR / "skaters.csv"

GOALIES_JSON = WORKING_DIR / "goalies_2024-2025.json"
GOALIES_CSV = WORKING_DIR / "goalies.csv"

SEP = ";"
NA = "NA"

URL_PLAYER_PREFIX = "https://www.puckpedia.com/player/"


def write_csv(p, all_position):
    with open(SKATERS_CSV, mode="a", encoding="UTF-8") as output:
        # p.nhl_rank = l[0]
        output.write("noNhlRank")
        output.write(SEP)

        # p.name = l[1]
        output.write(f"{p[Fields.first_name]} {p[Fields.last_name]}")
        output.write(SEP)

        # p.team = l[2]
        team_id = p[Fields.team_id]
        team_name = teams[int(team_id)] if team_id is not None else teams[-666]
        output.write(team_name)
        output.write(SEP)

        # p.last_team = l[3]
        output.write(NA)
        output.write(SEP)

        # p.position = l[4]
        position = p[Fields.position]  # ------------------- position ------------------
        output.write(f"{all_position}")
        output.write(SEP)

        # p.games = l[5]
        output.write(f"{p[Fields.games_played]}")
        output.write(SEP)

        # p.nhl_goals = l[6]
        goals = p[Fields.goals]
        output.write(f"{goals}")
        output.write(SEP)

        # p.nhl_assists = l[7]
        assists = p[Fields.assists]
        output.write(f"{assists}")
        output.write(SEP)

        # p.nhl_points = l[8]
        output.write(f"{p[Fields.points]}")
        output.write(SEP)

        if position in ["C", "L", "R"]:
            # p.goals = l[9]
            gg = int(goals) * 2
            output.write(f"{gg}")
            output.write(SEP)

            # p.assists = l[10]
            aa = int(assists) * 1
            output.write(f"{aa}")
            output.write(SEP)

            # p.points = l[11]
            output.write(f"{gg + aa}")
            output.write(SEP)

        elif position == "D":
            # p.goals = l[9]
            gg = int(goals) * 3
            output.write(f"{gg}")
            output.write(SEP)

            # p.assists = l[10]
            aa = int(assists) * 2
            output.write(f"{aa}")
            output.write(SEP)

            # p.points = l[11]
            output.write(f"{gg + aa}")
            output.write(SEP)

        # p.salary = l[12]
        output.write(f"{p[Fields.cap_hit]}")
        output.write(SEP)

        # p.rank = l[13]
        output.write("noPoolRank")
        output.write(SEP)

        # p.drafted = l[15]
        output.write("no")
        output.write(SEP)

        # p.age = l[16]
        output.write(f"{p[Fields.age]}")
        output.write(SEP)

        # p.draft_pick = l[17]
        output.write(f"{p[Fields.draft_pos] or 0}")
        output.write(SEP)

        # p.draft_year = l[18]
        output.write(f"{p[Fields.draft_year] or 0}")
        output.write(SEP)

        # p.year_left_contract = l[19]
        output.write(f"{p[Fields.contract_year_left]}")
        output.write(SEP)

        # # p.dff = l[20]
        # output.write(f"{p[Fields.dff]}")
        output.write("dff")
        output.write(SEP)

        # # p.reldff = l[21]
        # output.write(f"{p[Fields.reldff]}")
        output.write("reldff")
        output.write(SEP)

        # p.g60 = l[22]
        output.write(f"{p[Fields.g60]}")
        output.write(SEP)

        # p.p60 = l[23]
        output.write(f"{p[Fields.p60]}")
        output.write("\n")


positions = []

print(f'start: {datetime.now().strftime("%B %d, %Y %I:%M %p")}')

with open(Path(__file__).parent / "total.json", mode="r", encoding="UTF-8") as file:

    with open(SKATERS_CSV, mode="w", encoding="UTF-8") as output:
        output.write(
            "nhlRank;name;team;last_team;position;games;nhl_goals;nhl_assists;nhl_points;goals;assists;points;salary;pool_rank;drafted;age;draft_pick;draft_year;year_left_contract;dff;reldff;g60;p60"
        )
        output.write("\n")

    list_players = json.load(file)
    for player in list_players:

        try:
            url_player = f"{URL_PLAYER_PREFIX}{player[Fields.player_url]}"
            with sync_playwright() as p:
                browser = p.chromium.launch()
                page = browser.new_page()
                page.goto(url_player, wait_until=None)
                page.wait_for_selector("img.rounded-full")

                # print(page.locator("css=div.statsrow").nth(0).text_content())

                info = page.locator("css=div.statsrow").nth(0)
                position = info.locator("css=span.statsrow_val").nth(2).text_content()

                positions.append(position)
                browser.close()

            write_csv(player, position)
        except Exception:
            print(f"error! {player[Fields.player_url]}")

        # break


print(f'end: {datetime.now().strftime("%B %d, %Y %I:%M %p")}')
