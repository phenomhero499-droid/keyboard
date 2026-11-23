# THE LIGHT KEYBOARD — Real Android Keyboard (IME)

## v1.9 — Yalla fix: Enter ab neechay line nahi badlega (23 Nov 2026)

Muhammad ne kaha: "yarr keyboard yalla pr work nahi kr raha neechay wali line pr shift hooo jata" — Yalla mein type karne par message send hone ke bajaye cursor neechay wali line par chala jata tha.

**Asal wajah (root cause):** `sendEnterNow()` HAMESHA pehle Enter bhejta tha, phir 120 ms baad Accessibility click. Yalla Ludo ki chat Enter se send NAHI hoti — Enter sirf newline dalta hai, cursor neechay line par chala jata hai. Accessibility click asal send tha, lekin wo nuqsan-deh Enter KE BAAD aata tha, aur agar Accessibility OFF ho ya Yalla ka Send button koi node na de (Yalla game hai — Unity/WebView, us ka Send button aksar baghair text/description wala paper-plane icon hota hai) to kuch bhi send nahi hota tha.

**Fix v1.9:**
1. **Enter ab Yalla mein bilkul nahi bheja jata:** Auto-Click Send ON ho to send sirf Accessibility click se hota hai, Enter bilkul nahi. Enter sirf tab bheja jata hai jab Auto-Click OFF ho AUR Yalla Mode bhi OFF ho (WhatsApp jaisi apps ke liye fallback).
2. **Naya "Yalla Mode" toggle (Settings mein, default ON):** Yalla Mode ON ho to Enter kisi bhi soorat mein nahi bheja jata — sirf Accessibility click / tap fallback. OFF karein to purana behaviour (Enter fallback) wapas aa jata hai. Status line mein "Yalla Mode: ON (Enter kabhi nahi)" dikhta hai.
3. **Send button dhoondhna behtar:** Yalla ka Send button aksar baghair text wala paper-plane ImageView/ImageButton hota hai neechay-dayein kone mein — aise image ko ab bara bonus milta hai, aur accept karne ki hadd 40 se 25 kar di hai. One-shot guard + 1000 ms cooldown waisi hi hai — dobara click nahi hoga.
4. **Tap-gesture fallback:** Agar koi Send node hi na mile (Unity/WebView — koi node expose nahi hota) to EK dafa tap gesture: chat input (EditText) mila ho to us ki line par dayein kone (x = 0.93 * screen), na mile to screen ki 0.90 height par. Sirf EK dafa, dobara nahi.
5. **Warning Toast:** Agar Auto-Click ON ho lekin Accessibility OFF ho to ek keyboard session mein EK dafa Toast: "Accessibility ON karein — warna Yalla mein send nahi hoga, Enter sirf neechay line badlega". Har keystroke par spam nahi.

**Install:** Purani v1.8 installed hai to pehle use uninstall kar dein, phir v1.9 APK install karein. **Accessibility ON karna lazmi hai** — Settings mein "4. ACCESSIBILITY ON KAREIN" dabayein, status mein "Accessibility (Send-click): HAN ✓" hona chahiye, warna Yalla mein send nahi hoga (Enter ab band hai, is liye Accessibility ke baghair koi send rasta nahi bachta). Yalla Mode ON hi rakhein.

**Sachai / Limitations (v1.9):** Ye APK kisi real phone / asli Yalla mein test NAHI hua (yahan koi phone nahi hai). Sirf structure verify hua hai: signature, manifest, versionCode 10, Enter-free send path code mein. Yalla mein letter ab send hota hai ya neechay line par jata hai — ye Muhammad ko Yalla mein test karke batana parega.

# THE LIGHT KEYBOARD — Real Android Keyboard (IME)

## v1.8 — Numpad mein sirf EK send button (23 Nov 2026)

Muhammad ne kaha: "numpad mein joo neechay send button hai woh khatam
kr doo sirf ek hi send button hoo" — numpad mode mein bottom row wala
SEND khatam kar diya hai. Ab numpad mein sirf EK send button hai: right
side wala lamba vertical SEND (v1.7 wala, `send_tall.jpg`). Bottom row
mein ABC (wapas QWERTY par jane ke liye), mic, SPACE, backspace aur ⚙
Settings waisi hi hain — sirf SEND hata hai, aur bottom row ka weightSum
8 se 6 ho jata hai taake SEND ki jagah khaali na bache. QWERTY mode mein
bottom-row SEND waisa hi hai (Auto Drop / Auto-Click Send wahan waisi
hi kaam karte hain). Baaki sab v1.7 jaisa hi hai: alphabet design/theme,
QWERTY order, 52dp rows, numpad mein koi auto feature nahi.

**Install:** Purani v1.7 installed hai to pehle use uninstall kar dein,
phir v1.8 APK install karein. Keyboard enable + Accessibility ON wale
steps wahi hain (neeche dekhein).

**Sachai / Limitations (v1.8):** Ye APK kisi real phone / asli Yalla
mein test NAHI hua (yahan koi phone nahi hai). Sirf structure verify
hua hai: signature, manifest, versionCode 9, numpad mode mein bottom
SEND GONE aur tall SEND hi ek send button.

## v1.7 — Naya key design: alphabet sirf theme, numpad naya (23 Nov 2026)

Muhammad ne do design images bhejin — pehli alphabet keys ki (chamkeele
kaale keys, laal neon border, chaandi ke gothic haroof, laal L seb ke
saath), doosri numpad ki (1-9, ., 0, backspace, aur dayein taraf lamba
vertical SEND button).

**Alphabet keys — SIRF design/theme change, QWERTY waisa hi:**
QWERTY order waisa hi hai (Q W E R T Y U I O P / A S D F G H J K L /
Z X C V B N M) — design image wali A-Z alphabetical order NAHI lagayi.
Sirf keys ka look badla hai: kaala glossy key, laal neon border
(`key_bg_selector`, design image se match), chaandi ke SERIF bold
haroof (#E8E8E8), aur L key laal hai jaise image mein laal L seb ke
saath hai. Poori design images APK mein hain (`alphabet_design.jpg`,
`numpad_design.jpg`, aur `key_tile.png` alphabet image se banaya gaya
key tile). 52dp rows, wrap_content root, height ke liye koi weight
nahi — v1.6 layout rules waisi hi hain.

**Numpad — bilkul doosri image jaisa:**
Bayein taraf 3-column grid: 1 2 3 / 4 5 6 / 7 8 9 / . 0 backspace.
Dayein taraf EK lamba vertical SEND button, chaaron rows jitna lamba
(`send_tall.jpg` — image se crop kiya: laal paper plane + vertical
chaandi ke SEND haroof). **Numpad mein KOI auto feature nahi hai:**
number type karne par Auto Drop bhi nahi, Auto-Click Send bhi nahi —
numbers sirf text mein bhare jate hain, send karne ke liye lamba SEND
button khud dabana parega (ek dafa, one-shot guard waisa hi).
QWERTY mode mein saare auto features waisi hi hain jaisi pehle the.

**Install:** Purani v1.6 installed hai to pehle use uninstall kar dein,
phir v1.7 APK install karein. Keyboard enable + Accessibility ON wale
steps wahi hain (neeche dekhein).

**Sachai / Limitations (v1.7):** Ye APK kisi real phone / asli Yalla
mein test NAHI hua (yahan koi phone nahi hai). Sirf structure verify
hua hai: signature, manifest, versionCode 8, QWERTY order, numpad ka
lamba SEND, aur numpad mein auto-drop band. Design phone par kaisa
lagta hai — ye Muhammad ko phone par dekh kar, agar phir bhi masla ho
to naya screenshot bhej kar, batana parega.

---

## v1.6 — Layout Muhammad ke bheje hue XML jaisa, bilkul waisa (23 Nov 2026)

Muhammad ne khud apna layout XML bheja — root LinearLayout (match_parent /
wrap_content, vertical), har key row horizontal LinearLayout (match_parent /
52dp, weightSum = keys ki tadad), har key Button (0dp / match_parent,
layout_weight 1, plain text). v1.6 mein wahi structure bilkul waisa hi
lagaya gaya hai, koi naya layout invent nahi kiya: keyboard_view.xml aur
LightKeyboardService.buildKeys() dono mein har row FIXED 52dp hai aur
weightSum row ke keys ke barabar hai (10 / 9 / 7, keypad rows 4, neeche
wali row 56dp waisi hi, weightSum 8 — SPACE 2 ke barabar). Har key Button
hai, minHeight 0, padding 0, gravity CENTER, SANS_SERIF bold, plain ASCII
labels — letters key ke beech mein hain, Q/W saaf parhe jate hain. Height
ke liye koi weight nahi, code mein koi exact total height nahi — kul
height sirf 52dp rows + 56dp neeche wali row + padding se banti hai,
~220dp, Gboard jaisi. Root background sirf solid #111111 hai, koi bitmap
layout ko khainch nahi sakta.

**Install:** Purani v1.5 installed hai to pehle use uninstall kar dein,
phir v1.6 APK install karein. Keyboard enable + Accessibility ON wale
steps wahi hain (neeche dekhein).

**Sachai / Limitations (v1.6):** Ye APK kisi real phone / asli Yalla
mein test NAHI hua (yahan koi phone nahi hai). Sirf structure verify
hua hai: signature, manifest, versionCode 7, Muhammad wali 52dp rows
aur weightSum, height ke liye koi weight nahi. Keys ab phone par normal
size ki hain ya nahi — ye Muhammad ko phone par dekh kar, agar phir bhi
masla ho to naya screenshot bhej kar, batana parega.

---

## v1.5 — Keys ab normal size, typing ho sakegi (23 Nov 2026)

Muhammad ne v1.4 phone par test kiya aur screenshot bheja — keys ABHI
BHI bohot lambi theen, har row screen ka teesra hissa, letters key ke
neeche wale hisse mein — "is pr typing kaise karon ga ajeeb".

**Asal wajah (root cause):** v1.4 mein exact 300dp height set ki thi
AUR FrameLayout, keys_container aur har key row par layout_weight=1
tha, keys MATCH_PARENT height wali Buttons theen. Muhammad ke phone
par IME window 300dp se bohot lambi milti hai, aur weight-stretching
ne har row aur har key ko us lambi window bharne ke liye khainch diya.
Button ka default minimum height aur padding bhi letters ko neeche
dhakel deta hai. **Fix v1.5:** Height ke liye weight bilkul khatam —
root WRAP_CONTENT, har row FIXED 48dp, har key FIXED 48dp ki TextView
(weight sirf WIDTH ke liye), neeche wali row FIXED 56dp, root ka
background sirf solid #111111 (koi bitmap/ImageView nahi jo view ko
khainch sake). Kul height ab ~3x48 + 56 + padding = ~210dp hai, Gboard
jaisi. Letters key ke beech mein (gravity CENTER, minHeight 0) hain,
neeche nahi. Q/W plain ASCII, SANS_SERIF bold, waisi hi hain.

**Install:** Purani v1.4 installed hai to pehle use uninstall kar dein,
phir v1.5 APK install karein. Keyboard enable + Accessibility ON wale
steps wahi hain (neeche dekhein).

**Sachai / Limitations (v1.5):** Ye APK kisi real phone / asli Yalla
mein test NAHI hua (yahan koi phone nahi hai). Sirf structure verify
hua hai: signature, manifest, versionCode 6, fixed 48dp TextView keys
aur height ke liye koi weight nahi. Keys ab phone par normal size ki
hain ya nahi — ye Muhammad ko phone par dekh kar, agar phir bhi
lambi hon to naya screenshot bhej kar, batana parega.

---

## v1.4 — Chhota compact keyboard + Q/W theek (23 Nov 2026)

Muhammad ne v1.3 phone par test kiya aur screenshot bheja — 2 issues the:

**Issue 1 — Keyboard ke neeche bara khaali hissa:** Keys sirf upar the,
neeche aadhi screen sirf Crimson Throne background thi, bina keys ke.
**Asal wajah (root cause):** Root view ka background bitmap
`keyboard_bg.jpg` (1254x600) tha. Android mein kisi View ki minimum
height mein us ke background ki intrinsic height bhi shaamil hoti hai,
is liye Muhammad ke phone (~2x density) par root view ~1200px tall ho
gaya tha — WRAP_CONTENT ke bawajood. **Fix:** (1) Root ka background ab
solid rang hai (`#111111`, koi intrinsic size nahi) — bitmap ab root ka
background NAHI hai. (2) Image ab sirf ek fixed-height ImageView mein
hai (centerCrop), keys wale FrameLayout ke peeche, is liye wo keys ke
area se bahar kabhi nahi ja sakti. (3) `onCreateInputView()` ab keyboard
ki **EXACT height 300dp** set karta hai, aur key rows weight se
stretch hoti hain — keys poora 300dp bharte hain, neeche koi khaali
hissa nahi rehta. Keyboard ab Gboard jaisa compact hai.

**Issue 2 — Q aur W ajeeb lagte the:** Screenshot mein Q ulta/distorted
aur W lambda "Λ" jaisa lag raha tha. **Wajah:** Key Buttons phone ke
default font mein the aur un ka background aadha transparent (0xCC)
tha, is liye peeche wali chamkeeli laal image un ke peeche se jhalak
kar glyphs ko bigaar rahi thi. **Fix:** Har key Button ko ab plain
`Typeface.SANS_SERIF` bold milta hai, `setAllCaps(false)`, koi
transformation nahi, aur **poori tarah opaque** background
(`0xFF1A1A1A`). Labels plain ASCII hain (`displayFor`, Locale.US) —
"Q" aur "W" saaf dikhne chahiye.

Crimson Throne theme waisa hi hai — image abhi bhi keys ke peeche
halki (alpha 0.5) nazar aati hai, aur logo (launcher icon) v1.3 wala
hi hai. Baqi sab features waisi hi hain: Auto Drop, delay sirf
0/25/50/100/150/200 ms, Auto-Click Send (ek dafa), 123 keypad,
abc/ABC toggle, voice, Accessibility Send-click, ek ⚙ Settings button.

**Install:** Purani v1.3 installed hai to pehle use uninstall kar dein,
phir v1.4 APK install karein. Keyboard enable + Accessibility ON wale
steps wahi hain (neeche dekhein).

**Sachai / Limitations (v1.4):** Ye APK kisi real phone / asli Yalla
mein test NAHI hua (yahan koi phone nahi hai). Sirf structure verify
hua hai: signature, manifest, versionCode 5, fixed 300dp height aur
plain typeface code mein maujood. Keyboard ab phone par compact hai
aur Q/W saaf hain ya nahi — ye Muhammad ko phone par dekh kar,
agar phir bhi ghalat ho to naya screenshot bhej kar, batana parega.

---

## v1.3 — Logo aur background (23 Nov 2026)

Muhammad ne apni image di — **"Crimson Throne"** (Light Yagami, Death Note,
kaale takht par, peeche bara laal khoon wala chaand, haath mein laal seb,
Death Note kitaab, kaale shatranj ke badshah, laal taaj, aur neeche chamakta
hua laal keyboard). Ab yehi image app ka **logo** aur **background** hai:

- **App icon (logo):** Isi image se banaya hai — beech wala hissa (Light ka
  chehra, takht, laal chaand, taaj, seb) crop karke launcher icon banaya
  (`mipmap-xxxhdpi/ic_launcher.png` aur `drawable/ic_launcher_fg.png`).
  Phone ki home screen / app drawer mein ab yehi Crimson Throne logo
  nazar aayega, purana icon nahi.
- **Keyboard background:** Isi image ka wide band (laal chaand + takht +
  chehra) le kar dark (38% brightness) aur halka blur kiya, taake keys
  saaf parhi ja sakein (`drawable/keyboard_bg.jpg`). Keys ka rang aur
  size wahi hai — sirf peeche ab ye artwork hai.
- **Settings screen background:** Poori image ko dark + blur karke
  MainActivity ka background banaya (`drawable/main_bg.jpg`).
- **Source artwork:** Poori original image project mein bhi hai
  (`drawable/crimson_throne.png`) aur `assets/crimson_throne.png` mein
  bhi, taake aage se koi bhi screen isi se ban sake.

**Install:** Purani v1.2 installed hai to pehle use uninstall kar dein,
phir v1.3 APK install karein. Keyboard enable + Accessibility ON wale
steps wahi hain (neeche dekhein).

**Sachai / Limitations (v1.3):** Ye APK kisi real phone / asli Yalla
mein test NAHI hua (yahan koi phone nahi hai). Sirf structure verify
hua hai: signature, manifest mein IME + Accessibility components,
versionCode 4, aur APK ke andar naya icon/background maujood hain. Logo
aur background phone par kaisa lagta hai — ye Muhammad ko phone par
dekh kar batana parega.

---

## v1.2 — Kya badla (23 Nov 2026)

Muhammad ne v1.1 phone par test kiya aur 3 issues bataye — teeno fix kiye gaye:

**1. Keyboard poori screen par khulta tha (sirf keyboard nazar aata tha):**
Ab ye normal keyboard ki tarah khulta hai, Gboard jaisa — sirf neeche
wala hissa (~280-320dp), upar Yalla ki chat nazar aati rahegi. Fix:
`LightKeyboardService.onEvaluateFullscreenMode()` ab `false` return
karta hai, input view ki height `wrap_content` hai, aur keys normal
size (~50dp) ki hain. Koi fullscreen extract view nahi, keyboard koi
full-screen Activity nahi hai.

**2. Auto-Click baar baar click hota rehta tha:**
Ab ek send = EK dafa click, dobara nahi. Fix: one-shot guard —
send trigger hote hi saare pending timer cancel, `sendConsumed` flag
set, aur 1000 ms cooldown. Agla character type karne tak dobara
send nahi hoga. Accessibility service mein purana 0/150/400/800 ms
retry loop hata diya — ab ek click attempt hoti hai; sirf agar pehli
koshish ne kuch nahi kiya AUR chat mein text abhi bhi hai, to 400 ms
baad EK retry, us se zyada kabhi nahi. `onAccessibilityEvent` se
click trigger bhi hata diya (wo har UI change par dobara click kar
raha tha — yehi asal repeat ki wajah thi).

**3. Keyboard ka size normal jaisa, baqi functions ek Settings button mein:**
Keyboard par ab koi switch, status text ya delay row nahi hai — sirf
keys (QWERTY / 123 keypad), shift, mic, space, backspace, SEND, aur
EK ⚙ Settings button. ⚙ dabayein to Settings screen (MainActivity)
khulti hai, jis mein SAARE functions hain: Auto Drop ON/OFF,
Auto-Click Send ON/OFF, delay 0/25/50/100/150/200 ms, case mode
(abc/ABC/Auto), mic permission, keyboard enable/switch, Accessibility
status + enable button, aur Send-click test.

**Install:** Purani v1.1 installed hai to pehle use uninstall kar dein,
phir v1.2 APK install karein. Keyboard enable + Accessibility ON
wale steps wahi hain (neeche dekhein).

**Sachai / Limitations (v1.2):** Ye APK kisi real phone / asli Yalla
mein test NAHI hua (yahan koi phone nahi hai). Sirf structure verify
hua hai: signature, manifest mein IME + Accessibility components,
versionCode 3. Fullscreen fix aur one-click guard kaam karte hain ya
nahi — ye Muhammad ko phone par test karke batana parega.

---

## v1.1 — Kya badla (23 Nov 2026)

**Masla (v1.0):** Muhammad ne Yalla Ludo mein test kiya aur bataya —
"us mein enter press wala send nahi hota." Yalla ki chat Enter dabane
se send NAHI hoti. v1.0 sirf Enter key event bhejta tha, is liye Yalla
mein message type to ho jata tha, send nahi hota tha.

**Fix (v1.1):** Ek **Accessibility service** add ki hai
(`SendClickAccessibilityService.java`) jo Yalla ke chat ka **asli Send
button dhoondh kar khud daba deti hai**. Ab Auto Drop ka order ye hai:
1. Pehle Enter bheja jata hai (kuch apps mein Enter se send hota hai).
2. 120 ms baad Accessibility service Yalla ka Send button click karti
   hai — pehle "send" likha hua button dhoondhti hai, na mile to
   neeche-dayein taraf wala clickable send icon, na mile to bottom bar
   ka aakhri clickable button. Click na chale to us jagah tap gesture
   bhejti hai. 0 / 150 / 400 / 800 ms par dobara koshish karti hai.
3. Delay wahi hai: 0, 25, 50, 100, 150, 200 ms — Auto Drop ka timer
   pehle pura hota hai, phir ye send hota hai.

**NAYA STEP — lazmi hai (is ke baghair v1.1 bhi Yalla mein send nahi karega):**

1. APK install karein, app kholein.
2. **Keyboard enable karein** (pehle wala step — Settings → Keyboard ON).
3. **★ Accessibility ON karein:** App mein **"4. ACCESSIBILITY ON KAREIN"**
   dabayein → Settings → Accessibility → Installed services /
   Downloaded apps → **The Light Keyboard** → **ON** karein. Android
   ye khud ON nahi karne deta, aap ko khud karna parega.
4. App ke status mein **"Accessibility (Send-click): HAN ✓"** dikhna chahiye.
5. **"Send-click test"** dabayein — koshish bhej di jayegi.
6. Yalla kholein → chat → type karein → Auto Drop khud Send dabayega.

**Test kaise karein:** Yalla room mein chat kholein, delay 200 ms
rakhein, "A" type karein — 200 ms baad message send hona chahiye
bina Send dabaye. Agar na ho to: (a) status mein Accessibility HAN
hai ya nahi check karein, (b) delay 0 par try karein, (c) keyboard
ka laal SEND button dabayein (wo bhi ab Enter + Send-click karta hai).

**Sachai / Limitations (v1.1):**
- Ye APK kisi real phone / asli Yalla mein test NAHI hua (yahan koi
  phone nahi hai). Sirf structure verify hua hai: signature, manifest
  mein IME + Accessibility components, dex mein service class.
  Yalla ka Send button milta aur click hota hai ya nahi — ye Muhammad
  ko phone par test karke batana parega.
- Accessibility manually ON karni paregi; app khud ON nahi kar sakti.
- Agar Yalla apna Send button badal de (naya icon, nayi jagah), to
  finder ko update karna parega.
- Debug-signed APK hai (install ke liye theek, Play Store ke liye nahi).

---

**Roman Urdu (pehle ye parhein):** Ye ek asli Android keyboard hai, web page nahi.
Phone mein install hone ke baad ye Yalla Ludo, WhatsApp, Chrome — har app ke
andar keyboard ki tarah chalega. Purana wala keyboard sirf WhatsApp mein chalta
tha kyunke wo web page tha; ye system keyboard hai, is liye Yalla mein bhi chalega.

## Features / Kya karta hai

1. **Auto Drop (ON/OFF switch, default ON)** — Host "A" bole, aap "A" type
   karein, keyboard khud hi send kar dega. Send dabana nahi parega.
2. **Delay — sirf 0, 25, 50, 100, 150, 200 ms.** Keyboard par chips hain,
   jo select karein ge wahi delay asal mein lagega (Handler.postDelayed).
   Type karne ke baad utne ms ruk kar Enter bhejta hai.
3. **123 keypad** — Numbers phone jaisi keypad mein: 1 2 3 / 4 5 6 / 7 8 9 /
   \* 0 #. "123" dabayein to numbers, "ABC" dabayein to wapas letters.
4. **Small / Capital** — Shift button: abc → ABC → Aa (Auto). Jo case
   select ho, auto-drop usi case mein hota hai.
5. **Voice auto-type (mic 🎤)** — Mic dabayein, host jo bole (letter,
   number ya word) wo sun kar khud type karega, phir Auto Drop se send hoga.
   Mic permission app se allow karni paregi.
6. **Auto-Click Send (alag ON/OFF switch)** — Agar Auto Drop kaam na kare,
   to ye fallback hai: type hone ke baad utne hi delay par pehle Enter
   bhejta hai, phir **v1.1 mein Accessibility service app ka asli Send
   button khud daba deti hai** (is ke liye Accessibility ON karna lazmi
   hai — upar v1.1 section dekhein). Agar Accessibility OFF ho, to sirf
   Enter bheja jata hai, aur agar app ka Send button alag hai to
   keyboard ka apna laal SEND button dabayein.
7. **Theme** — Black + blood-red, Light Yagami (Death Note) style anime
   background. Naam: THE LIGHT KEYBOARD.

## APK banane ka tareeqa (Android Studio) — English

1. Install **Android Studio** (free, developer.android.com/studio).
2. Open this folder as a project: **File → Open → select this folder**.
3. Let it download Gradle 8.2 + Android Gradle Plugin 8.2.2 (first time
   internet chahiye). Set SDK location if asked (SDK 34).
4. **Build → Build App Bundle(s) / APK(s) → Build APK(s)**.
5. APK milega: `app/build/outputs/apk/debug/app-debug.apk`
   (release ke liye Build → Generate Signed App Bundle / APK).

Command line with Gradle (agar Android Studio nahi):
```
# local.properties mein apna SDK path likhein:
echo "sdk.dir=/Users/NAME/Library/Android/sdk" > local.properties
./gradlew assembleDebug
# APK: app/build/outputs/apk/debug/app-debug.apk
```

## APK banane ka tareeqa — bina Gradle (build-apk.sh)

Is project mein koi third-party library nahi hai (sirf Android framework,
pure Java), is liye APK bina Gradle ke bhi ban sakta hai:

```
export ANDROID_HOME=/path/to/android-sdk   # platform 34 + build-tools 34
export JAVA_HOME=/path/to/jdk-17
./build-apk.sh
# APK: out/app-debug.apk  (debug-signed, installable)
```

Ye script aapt2 → javac → d8 → zipalign → apksigner chalata hai.
**Note:** Isi tareeqe se ye APK yahan banaya gaya tha aur verify kiya gaya
(`apksigner verify`: v2+v3 signature OK, package `com.lightkeyboard`,
version 1.0, minSdk 24, targetSdk 34, IME service with BIND_INPUT_METHOD).

## Install aur enable karna (phone par)

1. APK phone mein copy karein aur install karein (Unknown sources allow).
   **Purani v1.0 installed hai to pehle use uninstall kar dein, phir
   v1.1 install karein.**
2. **The Light Keyboard** app kholein.
3. **1. KEYBOARD ENABLE KAREIN** dabayein → Settings → The Light Keyboard ON karein.
4. **2. SWITCH** dabayein → list mein se The Light Keyboard chunein.
5. **3. MIC PERMISSION** allow karein.
6. **★ 4. ACCESSIBILITY ON KAREIN (v1.1, lazmi):** App mein ye button
   dabayein → Settings → Accessibility → Installed services /
   Downloaded apps → The Light Keyboard → ON karein. Status mein
   "Accessibility (Send-click): HAN ✓" aana chahiye.
7. Yalla Ludo kholein → room → chat kholein → keyboard khud aa jayega.
   Host "A" bole → "A" type karein → delay ke baad pehle Enter, phir
   Accessibility service Yalla ka Send button khud daba degi.

## Files

- `app/src/main/java/com/lightkeyboard/LightKeyboardService.java` — keyboard
  (IME), Auto Drop, delay, voice, keypad, case.
- `app/src/main/java/com/lightkeyboard/SendClickAccessibilityService.java` — **v1.1**
  Send-button finder/clicker (Accessibility), retry logic, tap fallback.
- `app/src/main/java/com/lightkeyboard/MainActivity.java` — setup screen
  (v1.1: Accessibility enable + test buttons, live status).
- `app/src/main/java/com/lightkeyboard/Prefs.java` — settings (delay allowlist,
  v1.1: click-send request timestamp).
- `app/src/main/AndroidManifest.xml` — BIND_INPUT_METHOD service + **v1.1**
  BIND_ACCESSIBILITY_SERVICE service.
- `app/src/main/res/xml/accessibility_service_config.xml` — **v1.1** service config.
- `app/src/main/res/layout/keyboard_view.xml` — keyboard UI.
- `app/src/main/res/drawable/keyboard_bg.jpg` — anime background.
- `app/build.gradle.kts` — minSdk 24, targetSdk 34, AGP 8.2.2.
  Pure Java, zero third-party dependencies (no Kotlin, no AndroidX).
- `build-apk.sh` — manual APK build (aapt2/javac/d8/zipalign/apksigner).

## Limitations (sachai)

- v1.0 mein ye kisi aur app ke Send button ko touch nahi kar sakta tha
  (sirf Enter). **v1.1 mein Accessibility service Send button daba
  sakti hai, lekin sirf tab jab user ne Accessibility manually ON ki
  ho** — aur ye real phone / asli Yalla mein abhi test nahi hua.
- Voice recognition phone ki Google speech service par depend karta hai;
  agar phone mein Google app / speech service nahi, to mic kaam nahi karega.
- Debug APK signed nahi hota (development ke liye hai). Play Store ke liye
  release APK sign karna parega.
