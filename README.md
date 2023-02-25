# CrimsonTome's Blog

> My personal blog documenting my journey into open-source development alongside other things.  
> Created with Zola using the [terminimal theme](https://github.com/pawroman/zola-theme-terminimal), hosted on my VPS

![Repo Size](https://img.shields.io/github/repo-size/crimsontome/crimsontome.com)
![Commit Activity /month](https://img.shields.io/github/commit-activity/m/crimsontome/crimsontome.com)
![Last git commit](https://img.shields.io/github/last-commit/crimsontome/crimsontome.com)
[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

- [CrimsonTome's Blog](#crimsontomes-blog)
  - [Development](#development)
  - [Building](#building)
    - [Zola](#zola)
  - [Contributing](#contributing)
  - [Changelog](#changelog)
  - [License](#license)

## Development

- clone the repo
- run `zola serve` when in `src/blog/`
- make some changes and watch them update in the browser

## Building

### Zola

- run `zola build` when in `src/blog` (this will only give the right site if your domain matches the base url, Zola is weird like that. serve will work fine)


. . Docker instructions may return in the future . . 

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for information on adding to this repository.

## Changelog

Run `./changelog` to generate the changelog after your commit, then `git add . && git commit --amend --no-edit ` to generate the changelog  
The changelog is available [here](CHANGELOG)

## License

crimsontome.com is released under the MIT License. The full license text is included in the [LICENSE](LICENSE.md) file in this repository. Tldr legal have a [great summary](https://tldrlegal.com/license/mit-license) of the license if you're interested.
