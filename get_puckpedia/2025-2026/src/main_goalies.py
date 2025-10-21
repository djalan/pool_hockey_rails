from dataclasses import dataclass
import sys
from pathlib import Path

sys.path.append(Path(__file__).parent.parent.as_posix())

# from extract import Fields, teams
# from get import get_all_skaters
from definitions import DATA_DIR
from datetime import datetime
import json


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
    # reldff = "st_reldff"
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


GOALIES_JSON = WORKING_DIR / "goalies_2024-2025.json"
GOALIES_CSV = WORKING_DIR / "goalies.csv"

SEP = ";"
NA = "NA"

URL_PLAYER_PREFIX = "https://www.puckpedia.com/player/"


positions = []

print(f'start: {datetime.now().strftime("%B %d, %Y %I:%M %p")}')

with open(GOALIES_CSV, mode="w", encoding="UTF-8") as output:
    output.write(
        "nhlRank;name;team;last_team;position;games;nhl_goals;nhl_assists;nhl_points;goals;assists;points;salary;pool_rank;drafted;age;draft_pick;draft_year;year_left_contract;dff;reldff;g60;p60"
    )
    output.write("\n")

with open(Path(__file__).parent / "goalies.json", mode="r", encoding="UTF-8") as file:

    json_dict = json.load(file)
    # write_csv(player, position)

    with open(GOALIES_CSV, mode="a", encoding="UTF-8") as output:
        for p in json_dict["data"]["p"]:
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
            position = p[Fields.position]
            output.write(f"{position}")
            output.write(SEP)

            # p.games = l[5]
            output.write(f"{p[Fields.games_played]}")
            output.write(SEP)

            # p.nhl_goals = l[6]
            wins = p[Fields.wins]
            output.write(f"{wins}")
            output.write(SEP)

            # p.nhl_assists = l[7]
            shutouts = p[Fields.shutouts]
            output.write(f"{shutouts}")
            output.write(SEP)

            # p.nhl_points = l[8]
            output.write("0")
            output.write(SEP)

            # p.goals = l[9]
            ww = int(wins) * 3
            output.write(f"{ww}")
            output.write(SEP)

            # p.assists = l[10]
            ss = int(shutouts) * 5
            output.write(f"{ss}")
            output.write(SEP)

            # p.points = l[11]
            output.write(f"{ww + ss}")
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

            # p.dff = l[20]
            output.write("0")
            output.write(SEP)

            # p.reldff = l[21]
            output.write("0")
            output.write(SEP)

            # p.g60 = l[22]
            output.write("0")
            output.write(SEP)

            # p.p60 = l[23]
            output.write("0")
            output.write("\n")

        # break


print(f'end: {datetime.now().strftime("%B %d, %Y %I:%M %p")}')
