import json
from pathlib import Path
from dataclasses import dataclass


@dataclass
class Fields:
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
    dff = "st_dff"
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

WORKING_DIR = Path(__file__).parent

SKATERS_JSON = WORKING_DIR / "skaters_2024-2025.json"
SKATERS_CSV = WORKING_DIR / "skaters.csv"

GOALIES_JSON = WORKING_DIR / "goalies_2024-2025.json"
GOALIES_CSV = WORKING_DIR / "goalies.csv"

SEP = ";"
NA = "NA"

with open(SKATERS_JSON, mode="r", encoding="UTF-8") as file:
    json_dict = json.load(file)

with open(SKATERS_CSV, mode="w", encoding="UTF-8") as output:
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

        # p.dff = l[20]
        output.write(f"{p[Fields.dff]}")
        output.write(SEP)

        # p.reldff = l[21]
        output.write(f"{p[Fields.reldff]}")
        output.write(SEP)

        # p.g60 = l[22]
        output.write(f"{p[Fields.g60]}")
        output.write(SEP)

        # p.p60 = l[23]
        output.write(f"{p[Fields.p60]}")
        output.write("\n")


# -------
# Goalies
# -------
with open(GOALIES_JSON, mode="r", encoding="UTF-8") as file:
    json_dict = json.load(file)

with open(GOALIES_CSV, mode="w", encoding="UTF-8") as output:
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
