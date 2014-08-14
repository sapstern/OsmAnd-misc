#!/bin/bash
BASE=/var/lib/jenkins/osm-planet/regions
PBF_FILES="/var/lib/jenkins/workspace/Planet_Update-Extract Osm Maps Downloads/extracted/"

updateRegion() {
	echo "Update ${1} using ${2}"
	FILE="${BASE}/${1}.o5m"
	if [ ! -f $FILE ]; then
		osmconvert --out-o5m "${PBF_FILES}/${3}" -B=misc/osm-planet/${2} > ${FILE} 
	fi
    osmupdate $FILE ${BASE}/current-update.o5m -B=misc/osm-planet/${2} -v
    osmconvert --out-pbf $FILE > ${BASE}/${1}.osm.pbf
    mv -f $FILE ${FILE}.old || true
    # rm ${BASE}/${1}.o5m
    mv ${BASE}/current-update.o5m $FILE
}

rm current-update.o5m || true
# Europe
updateRegion Austria-wien metropolis-polygons/europe/austria/wien.poly europe.pbf

updateRegion England-london geo-polygons/europe/great-britain/england/greater-london.poly europe.pbf
updateRegion England-birmingham metropolis-polygons/europe/great-britain/birmingham.poly europe.pbf
updateRegion England-leeds metropolis-polygons/europe/great-britain/leeds.poly europe.pbf
 
updateRegion France-paris metropolis-polygons/europe/france/paris.poly europe.pbf
updateRegion France-lyon metropolis-polygons/europe/france/lyon.poly europe.pbf
updateRegion France-marseille metropolis-polygons/europe/france/marseille.poly europe.pbf
updateRegion France-toulouse metropolis-polygons/europe/france/toulouse.poly europe.pbf

updateRegion Germany-berlin geo-polygons/europe/germany/berlin.poly europe.pbf
updateRegion Germany-hamburg geo-polygons/europe/germany/hamburg.poly europe.pbf
updateRegion Germany-munich metropolis-polygons/europe/germany/munchen.poly europe.pbf
updateRegion Germany-ruhrgebiet-koln metropolis-polygons/europe/germany/ruhrgebiet-koln.poly europe.pbf

updateRegion Greece-athens metropolis-polygons/europe/greece/athens.poly europe.pbf

updateRegion Italy-roma metropolis-polygons/europe/italy/roma.poly europe.pbf

updateRegion Spain-madrid metropolis-polygons/europe/spain/madrid.poly europe.pbf

updateRegion Sweden-Stockholm metropolis-polygons/europe/sweden/stockholm.poly europe.pbf

updateRegion Turkey-istanbul metropolis-polygons/europe/turkey/istanbul.poly europe.pbf

# South-America
updateRegion Brazil-rio-de-janeiro-south-america metropolis-polygons/south-america/brazil/rio-de-janeiro.poly south-america.pbf
updateRegion Brazil-sao-paulo-south-america metropolis-polygons/south-america/brazil/sao-paulo.poly south-america.pbf

# Russia
updateRegion Russia-sankt-petersburg polygons/russia-regions/sankt-peterburg.poly russia.pbf
updateRegion Russia-moscow polygons/russia-regions/moscow.poly russia.pbf
updateRegion Russia-moscovskaya-oblast polygons/russia-regions/moskovskaya-oblast.poly russia.pbf

# United States
updateRegion US-chicago-north-america metropolis-polygons/north-america/us/chicago.poly us.pbf
updateRegion US-dallas-ford-worth-north-america metropolis-polygons/north-america/us/dallas-ford-worth.poly us.pbf
updateRegion US-houston-north-america metropolis-polygons/north-america/us/houston.poly us.pbf
updateRegion US-los-angeles-north-america metropolis-polygons/north-america/us/los-angeles.poly us.pbf
updateRegion US-new-york-north-america metropolis-polygons/north-america/us/new-york_philadelphia.poly us.pbf
updateRegion US-phoenix-north-america metropolis-polygons/north-america/us/phoenix.poly us.pbf
updateRegion US-san-antonio-north-america metropolis-polygons/north-america/us/san-antonio.poly us.pbf


ls -larh ${BASE}