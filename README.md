# Hockey Drafter

Ruby on Rails application pour préparer et exécuter un draft


## Installation

```bash
docker-compose build --no-cache
docker-compose up

docker container prune && docker volume rm pool_hockey_rails_pool_ruby_gems
```

## Usage

http://localhost:3000


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
apt install libsqlite3-dev

### Fix puma SSL compilation with bitnami image
apt install libssl-dev

### certbot certificate
- activate router rule for external port 80 and internal port 80
- stop docker so certbot can use port
- sudo certbot certonly --standalone

### fix rails console inside container
problem was TERM=xterm
fix1: TERM=dumb bundle exec rails c
fix2: apt install ncurses-bin


## License

[MIT](https://choosealicense.com/licenses/mit/)
