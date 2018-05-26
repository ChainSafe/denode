# Aragon Bare Boilerplate

> 🕵️ [Find more boilerplates using GitHub](https://github.com/search?q=topic:aragon-boilerplate) | 
> ✨ [Official boilerplates](https://github.com/search?q=topic:aragon-boilerplate+org:aragon)

Bare boilerplate for Aragon applications.

This boilerplate *only* includes the contract interfaces and `@aragon/client`, along with the two required application manifests: `manifest.json` and `arapp.json`.

This boilerplate is ideal for building applications that do not use React

## Usage

```sh
aragon init foo.aragonpm.test bare
```

## What's in the box?

### npm Scripts

- **test**: Runs your Truffle tests
- **build**: Compiles your contracts
- **start**: Runs your app locally
- **deploy**: Deploys your app smart contract to a local chain
- **publish**: Publishes a new version of your app

### Libraries

- [**@aragon/os**](https://github.com/aragon/aragonOS): Aragon interfaces
- [**@aragon/client**](https://github.com/aragon/aragon.js/tree/master/packages/aragon-client): Wrapper for Aragon application RPC
