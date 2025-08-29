import sys
from pathlib import Path

sys.path.append(Path(__file__).parent.parent.as_posix())

import json
import requests
from playwright.sync_api import sync_playwright
from definitions import DATA_DIR


PLAYERS_PER_PAGE = 100

URL_SKATERS = "https://puckpedia.com/players/api?q={%22player_active%22:[%221%22,%220%22],%22bio_pos%22:[%22lw%22,%22c%22,%22rw%22,%22d%22],%22bio_shot%22:[%22left%22,%22right%22],%22bio_undrafted%22:[%221%22],%22contract_level%22:[%22entry_level%22,%22standard_level%22],%22contract_next%22:[%220%22,%221%22],%22include_buyouts%22:[],%22contract_clauses%22:[%22%22,%22NMC%22,%22NTC%22,%22M-NTC%22],%22contract_start_year%22:%22%22,%22contract_signing_status%22:[%22%22,%22rfa%22,%22rfa_arb%22,%22ufa%22,%22ufa_no_qo%22,%22ufa_group6%22],%22contract_expiry%22:[%22rfa%22,%22rfa_arb%22,%22ufa%22,%22ufa_no_qo%22,%22ufa_group6%22],%22contract_arb%22:[%221%22,%220%22],%22contract_offs%22:[%221%22,%220%22],%22contract_structure%22:[%221way%22,%222way%22],%22sortBy%22:%22%22,%22sortDirection%22:%22DESC%22,%22curPage%22:1,%22pageSize%22:100,%22focus_season%22:%22161%22,%22player_role%22:%221%22,%22stat_season%22:%22161%22}"

HEADERS = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
    "referer": "https://puckpedia.com/players/search",
}


def new_url(url: str, page: int):
    CURRENT_PAGE = "curPage%22:1"
    new_page = CURRENT_PAGE.replace("1", str(page))
    return url.replace(CURRENT_PAGE, new_page)


def calculate_number_pages(page_dic) -> int:
    """Not used"""
    number_players = page_dic["data"]["meta"]["count"]
    return (number_players // PLAYERS_PER_PAGE) + 1


def get_skaters():
    """
    NOT WORKING
    403 error even with headers
    """
    response = requests.get(URL_SKATERS, headers=HEADERS)
    print(response.status_code)
    print(response.content)
    # assert response.status_code == 200


def demo_playwright():
    """Not used, just a Playwright Chrome automation HEADLESS demo"""
    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        page.goto("https://playwright.dev")
        print(page.title())
        browser.close()


def get_skaters_playwright(url: str, page_number: int):
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False)  # need real browser window
        page = browser.new_page()
        page.goto(url)
        content = page.content()
        browser.close()

    START = "<pre>"
    END = "</pre>"
    content_without_html_wrapping = content[
        content.find(START) + len(START) : content.find(END)
    ]

    # maybe files are useful later?
    # are they loading correctly with json.load(fullpath)?
    with open(DATA_DIR / f"{page_number}.json", mode="w") as f:
        f.write(content_without_html_wrapping)

    dic = json.loads(content_without_html_wrapping)
    players = dic["data"]["p"]

    return players


def get_all_skaters():
    all_players = []

    for page_number in range(1, 15):
        url = new_url(URL_SKATERS, page_number)
        players = get_skaters_playwright(url, page_number)
        all_players += players
        print(f"Page {page_number}: {len(players)} players")

    return all_players


if __name__ == "__main__":
    total_skaters = get_all_skaters()
    print(len(total_skaters))
