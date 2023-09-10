# Hockey Drafter
Ruby on Rails application pour préparer et exécuter un draft

## Installation on Linux
1) create `properties.private`
2) insert `MY_URL=my.site.com`
3)
```bash
bash build.sh
docker-compose build --no-cache --force-rm
docker-compose up
```
## Maintenance
```bash
docker container prune
docker volume rm pool_hockey_rails_pool_ruby_gems
```

## Usage
- http://localhost:3000
- http://localhost:3000/home/alainhello
- http://localhost:3000/home/alainbye

## Notes
### Fix position manually when resorting algorithms fail
https://api.rubyonrails.org/v4.2.9/classes/ActiveRecord/QueryMethods.html#method-i-where

```ruby
redraft.each do |r|
  k = Player.where(['season = ? AND name = ?', '2021-2022-keeper', r.name]).take
  k.my_rank_position = r.my_rank_position
  k.save
end
```

### Fix sqlite3 gem compilation with bitnami image
`apt install libsqlite3-dev`

### Fix puma SSL compilation with bitnami image
`apt install libssl-dev`

### certbot certificate
- activate router rule for internal/external port 80
- open http in firewall
- stop Rails server because certbot needs port 80
- `certbot certonly --standalone`

### certbot renew
- activate router rule for internal/external port 80
- open http in firewall
- `certbot renew --dry-run`
- `certbot renew`
- `cd /etc/letsencrypt/live/my.site.com/`
- `cp cert.pem /etc/ssl/private/my.site.com`
- `cp privkey.pem /etc/ssl/private/my.site.com`

### fix rails console inside container
problem was `TERM=xterm`

fix1: `TERM=dumb bundle exec rails console`

fix2: `apt install ncurses-bin`

### Get section names
- uncomment python `print(section_name)` and comment the stuff below
- Clean section name by removing stuff after the opening bracket `Defense (useless here)`
- `cat sections.txt | sed -n 's/\([^(]*\).*/\1/p' | sed 's/ \+$//g' | sort -u > sections_unique.txt`


### Get positions from NHL
```bash
curl -o teams.json 'https://statsapi.web.nhl.com/api/v1/teams?expand=team.roster&season=20232024'
cat teams.json | jq -r '.teams | .[] | .roster | .roster | .[] | "\(.person.fullName);\(.position.code)"'
```
