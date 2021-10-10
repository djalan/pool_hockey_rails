from requests import get
from bs4 import BeautifulSoup

BASE_URL = 'https://www.capfriendly.com/teams/'

teams = {
    'lightning': 'TBL',
    'capitals': 'WAS',
    'blues': 'STL',
    'oilers': 'EDM',
    'ducks': 'ANA',
    'jets': 'WPG',
    'canucks': 'VAN',
    'canadiens': 'MTL',
    'mapleleafs': 'TOR',
    'goldenknights': 'VGK',
    'flames': 'CGY',
    'stars': 'DAL',
    'hurricanes': 'CAR',
    'penguins': 'PIT',
    'avalanche': 'COL',
    'coyotes': 'ARI',
    'flyers': 'PHI',
    'sharks': 'SJS',
    'wild': 'MIN',
    'bruins': 'BOS',
    'sabres': 'BUF',
    'islanders': 'NYI',
    'blackhawks': 'CHI',
    'bluejackets': 'CLB',
    'rangers': 'NYR',
    'panthers': 'FLA',
    'predators': 'NAS',
    'redwings': 'DET',
    'senators': 'OTT',
    'kings': 'LAK',
    'devils': 'NJD',
    'kraken': 'SEA',
}

#teams = {'lightning': 'TBL'}

# Download
for team in teams:
    URL = f'{BASE_URL}{team}'
    FILENAME = f'get/{team}.html'
    with open(FILENAME, "wb") as file:
        response = get(URL)
        file.write(response.content)


#import pdb; pdb.set_trace()

# Parse
with open('salary.csv', 'w') as output:
    for team in teams:
        print(team)
        FILENAME = f'get/{team}.html'
        PRETTY = f'get/{team}.pretty.html'
        with open(FILENAME, 'r') as f:
            contents = f.read()
            soup = BeautifulSoup(contents, 'lxml')
            with open(PRETTY, 'w') as pretty:
                pretty.write(soup.prettify())
            table = soup.find('table', id='team')
            players_c = table.find_all('tr', {'class': ['odd c', 'even c']})
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
