# ssh-key-gen

generate ssh key file .

## features
- [x] ssh key gen
- [x] support custom topic,email and date 

## in plans

- ssh key del,lst through topic,email,date command

## Download


```bash
# speed up git clone in china
GC_PROXY="https://ghproxy.com/"
GC_URL="https://github.com/YMC-GitHub/ssh-key-gen"
GC_URL="${GC_PROXY}${GC_URL}"
git clone -b main "$GC_URL"
```

## Usage
- [x] get help (ps:`./index.sh -h`)

```bash
# ./index.sh -h
usage: {ns} [command] [option]
command:
    version -- output cli version
    help -- output usage

options:
    -p,--preset [value] -- use some preset
    -t,--topic <value> -- set hub url list. ps: ge or gh,ge,gl
    -e,--email <value> -- set email list. ps: x@163.com or x@163.com,x@126.com
    --today [value] -- set day of date . ps: 20230724
    -i,--input [value] -- input dir
    -o,--output [value] -- output dir
    --dryrun -- with dry run mode
    -h,--help -- info help usage
    -v,--version -- info version
```

- [x] get version (ps:`./index.sh -v`)
- [ ] download but not saving script to file and gen key . (ps:``)

```bash
GC_PROXY="https://ghproxy.com/"
GC_REPO_URL_RAW=https://raw.githubusercontent.com/ymc-github/pullk8s
url=${GC_PROXY}${GC_REPO_URL_RAW}/main/admk8s.dli.sh
# url=${GC_PROXY}${GC_REPO_URL_RAW}/main/microk8s.d2c.sh
# url=${GC_PROXY}${GC_REPO_URL_RAW}/main/microk8s.d2n.sh
echo $url
# curl -sfL $url | sh
```

<!-- get more usage on [docs](docs/tutorials/add-ssh-key-to-github.md) -->


## Author

name|email|desciption
:--|:--|:--
yemiancheng|<ymc.github@gmail.com>||

## License
MIT
