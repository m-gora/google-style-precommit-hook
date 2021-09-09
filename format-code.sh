#!/usr/bin/env sh
FORMATTER_VERSION="1.11.0"
FORMATTER="google-java-format-$FORMATTER_VERSION"
FORMATTER_JAR="$FORMATTER-all-deps.jar"
mkdir -p .cache
cd .cache
if [ ! -f $FORMATTER_JAR ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/v$FORMATTER_VERSION/$FORMATTER_JAR"
    chmod 755 $FORMATTER_JAR
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$")
echo $changed_java_files
java -jar .cache/$FORMATTER_JAR --replace $changed_java_files
