#! /usr/bin/env python

from requests import get
from bs4 import BeautifulSoup
from sys import exit

BASE_URL = 'https://www.capfriendly.com/teams/'
DOWNLOADS_DIR = 'downloads'


teams = {'lightning': 'TBL'}


#import pdb; pdb.set_trace()

# Parse
with open('salary.csv', 'w') as output:
    for team in teams:
        print(team)
        FILENAME = f'{DOWNLOADS_DIR}/{team}.html'
        PRETTY = f'{DOWNLOADS_DIR}/{team}.pretty.html'
        with open(FILENAME, 'r') as f:
            contents = f.read()
            soup = BeautifulSoup(contents, 'lxml')
            with open(PRETTY, 'w') as pretty:
                pretty.write(soup.prettify())

            #table = soup.find('table', id='team')
            #players_c = table.find_all('tr', {'class': ['odd c', 'even c']})

            tables = soup.find_all('table', {"class": 'cf_teamProfileRosterSection__table'})
            #tables = soup.find_all('div', {"class": 'cf_teamProfileRosterSection__table_wrapper'})
            print(len(tables))
            for table in tables:
                section_name = table.find('th').text
                print(section_name)
            exit(0)

            for player in players_c:
                team_abbr = teams[team]
                td = player.find_all('td')
                href = td[0].find('a').get('href')
                try:
                    cap = td[8].find("span", class_='cap').text
                except AttributeError:
                    cap = '0'
                name = href[9:].replace('-', ' ').title()
                caphit = cap.replace('$', '').replace(',', '')
                output.write(f'{name};{caphit};{team_abbr}\n')
