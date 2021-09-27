#!/usr/bin/env sh
FORMATTER_VERSION="1.11.0"
FORMATTER="google-java-format-$FORMATTER_VERSION"
FORMATTER_JAR="$FORMATTER-all-deps.jar"
BASEPATH=$(dirname $0)
mkdir -p $BASEPATH/.cache

if [ ! -f $BASEPATH/.cache/$FORMATTER_JAR ]
then
    curl -LJOo $BASEPATH/.cache/$FORMATTER_JAR "https://github.com/google/google-java-format/releases/download/v$FORMATTER_VERSION/$FORMATTER_JAR"
    chmod 755 $FORMATTER_JAR
fi

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$")
echo $changed_java_files
java -jar .cache/$FORMATTER_JAR --replace $changed_java_files
