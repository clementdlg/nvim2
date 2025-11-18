# Introduction
- This project is an automated tool for building Neovim.
- It uses docker to perform the compilation. All the build dependencies are installed inside of the docker container.
- It can build any git ref, like a specific branch, a tag or a commit hash.

# Requirements
- packages : 
```
git docker-cli docker-buildx docker-compose
```
- basic git knowledge

---
# Default build
- this will build neovim using the default BUILD ARGS from the docker-compose file.
```bash
docker compose build
```

---
# Build args
### REF_TYPE
- the `REF_TYPE` variable is used to define the type of git ref that will be used. 
- Possibles values are :
    - `branch` : the branch name
    - `tag` : any existing tag on this repo
    - `commit` : the **full** commit hash of a particular commit

### GIT_REF
- the git ref to clone. 
Examples :
- for `REF_TYPE=branch`, you can set `GIT_REF=master` or `GIT_REF=release-0.11`
- for `REF_TYPE=tag`, you can set `GIT_REF=v0.11` or `GIT_REF=stable`
- for `REF_TYPE=commit`, you can set to any random commit hash, like `GIT_REF=dff06a90e496c93931b4761ee9538a301477690f`

### ARCH
- this is a work in progress, it does not work yet
- the `ARCH` variable is used to select the CPU architecture to compile Neovim for.
- Supported architectures are :
    -  `ARCH=x86_64`
    -  `ARCH=aarch64` (macOs)

---
# Usage
### Using the docker compose
- edit variables under `args` in `docker-compose.yml`
```yaml
services:
  nvim:
    build:
      context: .
      dockerfile: build/Dockerfile.compile
      args:
        GIT_REF: # put your git ref here
        REF_TYPE: # put your ref type here
        ARCH: x86_64
    image: nvim-dc
```
### Build
- use this command. It will use the parameters from the docker-compose file
```bash
docker compose build
```

### Run
- use the docker run command
```
docker run -ti --rm nvim-dc
```

