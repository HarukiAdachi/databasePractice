-- 問1
-- 国名を全て抽出してください。
Select name FROM countries;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。
SELECT *FROM countries WHERE region LIKE '%Europe%';

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。
SELECT *FROM countries WHERE region NOT LIKE '%Europe%';

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。
SELECT *FROM countries WHERE population >= 100000;

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。
SELECT *FROM countries WHERE life_expectancy BETWEEN 56 AND 76;

-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。
select *from cities where country_code='NLB' or country_code='ALB' or country_code='DZA';

-- 問7
-- 独立独立記念日がない国をすべて抽出してください。
select *from countries where indep_year is NULL;

-- 問8
-- 独立独立記念日がある国をすべて抽出してください。
select *from countries where indep_year is NOT NULL;

-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。
select *from countries where name like '%ia';

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。
select *from countries where name like '%st%';

-- 問11
-- 名前が「an」で始まる国を抽出してください。
select *from countries where name like 'An%';

-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。
select *from countries where indep_year <= 1990 or population >= 100000;

-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。
select *from countries where (code = 'DZA' or code = 'ALB') and indep_year <= 1990;

-- 問14
-- 全ての地方をグループ化せずに表示してください。
select region from countries ;

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」
select concat(name, 'の人口は', population, '人です') from countries;

-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。
select *from countries where life_expectancy is not NULL order by life_expectancy asc;

-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。
select *from countries where life_expectancy is not NULL order by life_expectancy desc;

-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。
select * from countries where life_expectancy is not NULL and indep_year is not NULL order by life_expectancy de
sc, indep_year desc;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。
select SUBSTRING(code, 1, 1) , name from countries;

-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。
select name, length(name) from countries order by length(name) desc;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)
 select region, life_expectancy,population from countries order by region asc;

-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)
select region, MAX(life_expectancy) as "最長寿命", MAX(population) as "最大人口" from countries group by region order by region;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください
select surface_area as "アジアの最小面積" from countries where region in ('Eastern Asia', 'Southern and Central Asia', 'Southeast Asia') order by surface_area asc limit 1;

-- 問24
-- アジア大陸の表面積の合計を表示してください。
select sum(surface_area) as "アジア大陸の表面積の合計" from countries where region in ('Eastern Asia', 'Southern and Central Asia', 'Southeast Asia');

-- 問25
-- 全ての国と言語を表示してください。一つの国に複数言語があると思いますので同じ国名を言語数だけ出力してください。
select countries.name, country_languages.language from countries join country_languages on countries.code = country_languages.country_code order by countries.name, country_languages.language;

-- 問26
-- 全ての国と言語と市区町村を表示してください。
select countries.name, country_languages.language, cities.name as "市区町村" from countries join country_languages on countries.code = country_languages.country_code join cities on countries.code = cit
ies.country_code order by countries.name, country_languages.language, cities.name;

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。
select celebrities.name, countries.name from celebrities left join countries on celebrities.country_code = countries.code order by celebrities.name;

-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。
select celebrities.name, countries.name, country_languages.language from celebrities left join countries on celebrities.country_code = countries.code left join country_languages ON countries.code = country_languages.country_code where country_languages.is_official = 'T' order by celebrities.name;

-- 問29
-- 全ての有名人の名前と国名をに出力してください。 ただしテーブル結合せずサブクエリを使用してください。
select celebrities.name, (select countries.name from countries where countries.code = celebrities.country_code) from celebrities;

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。
select country_code,MAX(age), MIN(age) from celebrities where country_code is not NULL group by country_code having MAX(age) >=50 and MIN(age) <= 30;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。
select '1991' as "誕生年" ,count(*) as "人数" from celebrities where EXTRACT(YEAR FROM birth) = 1991 UNION select '1981', count(*) from celebrities where EXTRACT(YEAR FROM birth) = 1981;

-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
select countries.name as "国名", AVG(celebrities.age) as "平均年齢" from celebrities join countries on celebrities.country_code = countries.code group by countries.name order by "平均年齢" DESC;