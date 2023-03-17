Flutter fejlesztő feladat
Az Hunelco fejlesztői csapatunk nevében köszönjük, hogy jelentkezéseddel időt és energiát
fordítasz arra, hogy csatlakozz csapatunkhoz! Ezen feladat segítségével szeretnénk
megismerni a kódolási stílusodat, továbbá rálátást szeretnénk kapni jelenlegi programozási
ismereteidre.
1. Feladatleadás
Arra kérünk, hogy az elkészített feladatodat töltsd fel egy általad választott git repository-ba és
oszd meg a boldizsar.schon@hunelco.com e-mail címmel. Ezen az e-mail címen nyugodtan
keress kérdés esetén.
2. Feladatról
A feladatod egy film adatbázis alkalmazás fejlesztése lesz, amely két képernyőből fog állni. A
filmeket egy online API-tól kérd le.
A fejlesztés során használj valamilyen StateManagement-et (pl BLoC, RiverPod, stb.). Továbbá
az egyes API hívások alatt legyen jelezve a töltés, illetve a hiba is (pl nincs net a lekérés
közben).
Az sem baj, ha valamelyik feladatra már csak részben, vagy nem jutott idő. Ez esetben azt is
értékeljük, ha ezekre a feladatokra szövegesen leírod, hogy hogyan, milyen lépésekben
valósítanád meg.
API: https://developers.themoviedb.org/3/
API KEY: 1b2ebef24b42da2c2eb14b613afaaae7
3. Funkciók:
1. Főképernyő: API-ról lekérve valósíts meg keresési lehetőséget, amely a film címére szűr.
Valósíts meg lapozódást (pagination). Egyszerre 10 filmet tölts be a listába. A lista végéhez
érkezve töltődjön be további 10 db film. Legjobb példa erre a Facebook hírfolyam
működési elve.
a. API: https://developers.themoviedb.org/3/search/search-movies
2. Részletes képernyő: A kilistázott filmeknek valósíts meg egy részletes képernyő nézetet
(tetszőleges designnal)
a. API: https://api.themoviedb.org/3/movie/{move_id}
4. Plusz feladatok, amiket nagyra értékelünk
• Készítsd fel az alkalmazásodat az offline működésre is
• Írj unit teszteket a keresés algoritmusához.
5. Értékelési szempontok
• futtatható alkalmazás Androidos eszközön
• nem áll le az alkalmazás hiba, vagy ANR miatt
• jól értelmezhető forráskód, kódbázis
architekturális szerveződése
• feladatok megvalósítása.
6. Képernyőkép
Itt egy példa képernyőkép, de bármilyen, általad készített átlátható design is megfelelő
