<?php

function loadIndexesFromDir($output, $outputIndexes, $dir, $fileFilter, $timestamp){
  if (is_dir($dir)) {
    if ($dh = opendir($dir)) {
      while (($file = readdir($dh)) !== false) {
        if(startsWith($file, $fileFilter)) {
            $indexName=$file;
            $filename = $dir . $file ; //"./test112.zip";
            $size =  number_format((filesize($filename) / (1024.0*1024.0)), 1, '.', '');
            $containerSize = filesize($filename);
            $contentSize = filesize($filename);
            $date= date('d.m.Y',filemtime($filename));
            $timestampF = filemtime($filename);
            if($timestampF * 1000 > $timestamp) {
              $out = $output->createElement( $elementName);
              $outputIndexes->appendChild($out);
              $out -> setAttribute("containerSize", $containerSize);
              $out -> setAttribute("contentSize", $contentSize);
              $out -> setAttribute("timestamp", $timestampF * 1000);
              $out -> setAttribute("date", $date);
              $out -> setAttribute("size", $size);
              $out -> setAttribute("name", $indexName);
            }
        }
      }
      closedir($dh);
    }
  } else {
    print($dir . " not a directory!\n");
  }
}


if(!isset($_GET['file'])  || !isset($_GET['timestamp']) ) {
   header('HTTP/1.0 404 Not Found');
   die(1);
 }



$dom = new DomDocument();
$output = new DOMDocument();
$output->formatOutput = true;
$outputIndexes = $output->createElement( "updates" );
$outputIndexes->setAttribute('file', $_GET['file']);
$outputIndexes->setAttribute('timestamp', $_GET['timestamp']);
$output->appendChild( $outputIndexes );
loadUpdatesFromDir($output, $outputIndexes, 'osmc/', $_GET['file'], $_GET['timestamp']);

echo $output->saveXML();   
?>
