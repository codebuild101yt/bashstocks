# bashstocks

`bashstocks` is a Bash script that fetches and displays stock information using the Alpha Vantage API.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Options](#options)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- Bash (Bourne Again SHell)
- `curl` command-line tool
- `jq` command-line JSON processor

## Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/bashstocks.git
cd bashstocks
```
Make the script executable:

```bash
chmod +x bashstocks.sh
```

## Usage

```bash
./bashstocks.sh <stock_symbol>
```
Replace <stock_symbol> with the symbol of the stock you want to retrieve information for.

## Examples
Retrieve information for Apple Inc. (AAPL):

```bash
./bashstocks.sh AAPL
```

Retrieve information for Alphabet Inc. (GOOGL):
```bash
./bashstocks.sh GOOGL
```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs, feature requests, or suggestions.
