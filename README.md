# build the docker :
## default build
- this will compile the latest stable version of neovim for the AMD64 architecture
```
docker build -t nvim-dc . -f build/Dockerfile
```

## Build variables
### change the neovim version
- defaut : `BRANCH=stable`
- example : `BRANCH=master`

### target architecture : 
- defaut : `ARCH=x86_64`
- example : `ARCH=aarch64`

### manual command
- run a command like this :
```
docker build \
    -t nvim-dc \
    -f build/Dockerfile \
    --build-arg BRANCH=stable \
    --build-arg ARCH=x86_64 \
    .
```

### using the docker compose
- edit the `docker-compose.yml`, then run this command :
```
docker compose build
```

# run the docker
```
docker run -ti --rm nvim-dc
```

