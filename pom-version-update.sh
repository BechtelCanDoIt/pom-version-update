#!/bin/bash

VERSION=$1

ARTIFACT_IDS=~/tmp/artifactIds

POM_VERSIONING_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INCLUDES=$POM_VERSIONING_HOME/includes

rm -rf ~/tmp
mkdir -p ~/tmp

sed "s/PROJECT_VERSION/$VERSION/" $INCLUDES/updatePomVersion.xslt > ~/tmp/transform.xslt
sed "s/PROJECT_VERSION/$VERSION/g" $INCLUDES/updateParentPomVersion.xslt > ~/tmp/transformParent.xslt

for pom in $(find . -name pom.xml | grep -v "/target/")
do
    sed -i "s/\(<[^>\"']*\):\([^>\"']*\):/\1_abcdefg_\2_abcdefg_/g" $pom
    xsltproc -o $pom ~/tmp/transform.xslt $pom
    xmlstarlet sel -T -t -m '/_:project/_:artifactId' -v '.' -n $pom >> $ARTIFACT_IDS
    sed -i "s/_abcdefg_/:/g" $pom
done

PARENT_ARTIFACT_CONDITION="pom:artifactId='blah'"
for parent in $(cat $ARTIFACT_IDS)
do
    PARENT_ARTIFACT_CONDITION="$PARENT_ARTIFACT_CONDITION or pom:artifactId='$parent'"
done

sed -i "s/PARENT_ARTIFACT_CONDITION/$PARENT_ARTIFACT_CONDITION/g" ~/tmp/transformParent.xslt

for pom in $(find -name pom.xml | grep -v "/target/")
do
    sed -i "s/\(<[^>\"']*\):\([^>\"']*\):/\1_abcdefg_\2_abcdefg_/g" $pom
    xsltproc -o $pom ~/tmp/transformParent.xslt $pom
    sed -i "s/_abcdefg_/:/g" $pom
done
