#!/bin/bash
repositoryName=$1
gh repo create templatenathan/$repositoryName --template "https://github.com/templatenathan/template" --public

while [ ! -f $repositoryName/package.json ]
do
  rm -rf $repositoryName
  sleep 0.1
  gh repo clone github.com/templatenathan/$repositoryName
done

cd $repositoryName
sed -i '' -e "s/\"name\": \"template\"/\"name\": \"$repositoryName\"/g" "package.json"
npm i
git add .
git commit -m "chore: change 'template' to '$repositoryName' in package json"
git push
echo "finished setting up the repo: $repositoryName"
code .
