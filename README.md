# Automated CSV & System Log Auditor (Ruby)

A lightweight **Ruby** command-line data-quality utility that parses structured CSV system exports, checks for missing required fields and out-of-bounds operational metrics, and prints an itemized audit report.

## Key Features
- **Schema & Null Validation:** Detects blank or missing required system identifiers before downstream database ingestion.
- **Boundary Checks:** Flags impossible metric values (such as uptime percentages below `0%` or above `100%`).
- **Zero External Dependencies:** Built using Ruby's standard `csv` library for fast, portable execution.

## How to Run Locally
```bash
git clone https://github.com
cd ruby-csv-data-auditor
ruby auditor.rb
```
