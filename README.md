# :moneybag: FS25 Bank Account Interest
Adds interest calculations so that a farm's bank balance earns interest at the beginning of every month. The default rate is 1% APY.

Two dev console commands have been added to control the interest rate:
- `biSetInterestRate <interest_rate>` - allows the modification of the interest rate. ex: `biSetInterestRate 0.01` would set the interest rate to the default.
- `biGetInterestRate` - prints the current interest rate to the console.

## :gear: Manual Install Instructions
1. Download `FS25_BankAccountInterest_update.zip` from the latest release on the [releases page](https://github.com/EvanKirsch/fs25-bank-account-interest/releases/latest)
1. Move your downloaded copy of `FS25_BankAccountInterest_update.zip` to `Documents\My Games\Farming Simulator 2025\mods`

## :hammer_and_wrench: Manual build instructions
`git archive -o FS25_BankAccountInterest.zip HEAD`

## :rocket: Release
Create and push a tag on the desired release commit following the pattern `[0-9]+.[0-9]+.[0-9]+.[0-9]+`

```bash
git tag <tagname>
git push origin <tagname>
```
