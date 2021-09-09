#!/usr/bin/env sh
FORMATTER="google-java-format-1.11"
FORMATTER_JAR="$FORMATTER-all-deps.jar"
mkdir -p .cache
cd .cache
if [ ! -f google-java-format-1.7-all-deps.jar ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/$FORMATTER/$FORMATTER_JAR"
    chmod 755 google-java-format-1.7-all-deps.jar
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$")
echo $changed_java_files
java -jar .cache/$FORMATTER_JAR --replace $changed_java_files
