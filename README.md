# GitHub pull

The purpose of this piece of code is to locally clone content from  authors on
GitHub repositories and keep them in sync by Git pulling.
In the current state, it is written to work on Linux systems, maybe some day
a Windows one will be written.

## Dependencies

There are a few dependencies which are :
- curl
- git
- A [GitHub authentication key][github_auth]

## How to use

Edit the pull.txt file, add the authors from whom you want to keep the content
in sync locally.
Edit the token file and add your credentials in it, as the provided file 
**won't** work.

Then, either run the bash script with the following :
```bash
$> chmod +x
$> ./pull.sh

# OR

$> /bin/bash pull.sh
```

## Disclaimer

The content of this repository is provided as-is and I cannot be held 
responsible for any issue that might happen.

[github_auth]: https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token 
