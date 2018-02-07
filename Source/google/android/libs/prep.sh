#/bin/sh
set -e
mvn -Dandroid.sdk.dir=$1 package
rm -rf res/
rm -f classes.jar
mkdir -p res/
for filename in *.aar; do
  base=${filename%.aar}

  unzip ${filename} classes.jar
  mv classes.jar ${base}.jar

  unzip ${filename} "res/*" -d res/${base}
  if [ "$(ls -A res/${base}/res/)" ]; then
    mv -f res/${base}/res/** res/${base}/
  else
    rm -r res/${base}
  fi
done
