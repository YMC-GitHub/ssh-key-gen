```bash
# in bash shell

# gen ssh key
./ssh.keygen.sh -t=gh -e=ymc.github@gmail.com --today=230724


# lst ssh
ls ~/.ssh/ymc.github@gmail.com/230724

# clip public key to clipboad
# ps:
clip < ~/.ssh/gh/230724.pub

# add to github
# ...
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

# add to ssh-agent
# ps:
eval $(ssh-agent -s)
ssh-add ~/.ssh/gh/230724

# check connecting to github
# ps:
ssh -T git@github.com
```