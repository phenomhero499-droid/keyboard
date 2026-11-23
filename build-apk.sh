#!/bin/bash
# THE LIGHT KEYBOARD — manual APK build, no Gradle, no downloads.
# Uses only: JDK 17 (javac/keytool), Android SDK platform 34 + build-tools 34.
#   ANDROID_HOME=/path/to/android-sdk ./build-apk.sh
# Output: out/app-debug.apk  (debug-signed, installable)
set -e
cd "$(dirname "$0")"

if [ -z "$JAVA_HOME" ]; then
  for d in /home/hatch/opt/jdk-17* /usr/lib/jvm/java-17* /opt/jdk-17*; do
    [ -d "$d" ] && JAVA_HOME="$d" && break
  done
fi
export JAVA_HOME
export PATH="$JAVA_HOME/bin:$PATH"

SDK="${ANDROID_HOME:-$ANDROID_SDK_ROOT}"
[ -n "$SDK" ] || { echo "ANDROID_HOME set karein (Android SDK ka path)"; exit 1; }
BT="$SDK/build-tools/34.0.0"
PLATFORM_JAR="$SDK/platforms/android-34/android.jar"
[ -f "$PLATFORM_JAR" ] || { echo "platform android-34 nahi mila: $PLATFORM_JAR"; exit 1; }

rm -rf out && mkdir -p out/gen out/classes out/dex

echo "== 1. aapt2 compile resources =="
"$BT/aapt2" compile --dir app/src/main/res -o out/compiled.zip

echo "== 2. aapt2 link (APK + R.java) =="
"$BT/aapt2" link -o out/app-unsigned.apk \
  --manifest app/src/main/AndroidManifest.xml \
  -I "$PLATFORM_JAR" \
  --java out/gen \
  --auto-add-overlay \
  --version-code 10 --version-name 1.9 \
  --min-sdk-version 24 \
  --target-sdk-version 34 \
  out/compiled.zip

echo "== 3. javac =="
javac -encoding UTF-8 -source 17 -target 17 -nowarn \
  -cp "$PLATFORM_JAR" -d out/classes \
  out/gen/com/lightkeyboard/R.java \
  app/src/main/java/com/lightkeyboard/*.java

echo "== 4. d8 dex =="
jar --create --file out/classes.jar -C out/classes .
"$BT/d8" --lib "$PLATFORM_JAR" --output out/dex/ out/classes.jar

echo "== 5. add classes.dex =="
python3 -c "
import zipfile
z = zipfile.ZipFile('out/app-unsigned.apk', 'a', zipfile.ZIP_DEFLATED)
z.write('out/dex/classes.dex', 'classes.dex')
z.close()
print('classes.dex added')
"

echo "== 6. zipalign =="
"$BT/zipalign" -f 4 out/app-unsigned.apk out/app-aligned.apk

echo "== 7. sign (debug keystore) =="
if [ ! -f debug.keystore ]; then
  keytool -genkeypair -alias androiddebugkey -keyalg RSA -keysize 2048 \
    -validity 10000 -keystore debug.keystore -storepass android \
    -keypass android -dname "CN=Android Debug,O=Android,C=US" -noprompt
fi
"$BT/apksigner" sign --ks debug.keystore --ks-pass pass:android \
  --key-pass pass:android --out out/app-debug.apk out/app-aligned.apk

echo "== 8. verify =="
"$BT/apksigner" verify out/app-debug.apk && echo "APK VERIFIED OK"
ls -lh out/app-debug.apk
