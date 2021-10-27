# Hockey Drafter

Ruby on Rails application pour préparer et exécuter un draft


## Installation

```bash
docker-compose up --build
```

## Usage

http://localhost:3000


## Notes

https://api.rubyonrails.org/v4.2.9/classes/ActiveRecord/QueryMethods.html#method-i-where

```ruby
redraft.each do |r|
  k = Player.where(['season = ? AND name = ?', '2021-2022-keeper', r.name]).take
  k.my_rank_position = r.my_rank_position
  k.save
end
```


## License

[MIT](https://choosealicense.com/licenses/mit/)
