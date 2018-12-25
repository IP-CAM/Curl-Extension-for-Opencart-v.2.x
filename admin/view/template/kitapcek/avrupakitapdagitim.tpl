<?php
error_reporting(-1);
@ini_set("display_errors", 1);
@ini_set('memory_limit', '-1');
@set_time_limit(0);
@clearstatcache();
//Change Execution Time to 8 Hours
@ini_set('max_execution_time', 28800);
@ini_set('output_buffering',0);
header("Cache-Control: no-cache, must-revalidate");
date_default_timezone_set('UTC');

echo $header; ?><?php echo $column_left; ?>

<?php

class BKBOT {

public $booksarr = array();

/* Berat Kara - 06-12-2018 Opencart Curl Books */

public $categories = array();
public $products = array();

function __construct($kat,$product)
{
    $this->categories = $kat;
	$this->products = $product;
}

function arrgetir()
{
	return $this->booksarr;
}

function file_download($url,$name,$folder){
		
		if (!file_exists($folder))
			mkdir($folder);
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL,$url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_BINARYTRANSFER,1);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		$file=curl_exec($ch);
		curl_close($ch);

		$fp = fopen($folder."/".$name,'w');
		fwrite($fp, $file);
		fclose($fp);
}

function url_seo($str, $options = array()){
 
    $str = mb_convert_encoding((string)$str, 'UTF-8', mb_list_encodings());
 
 
    $defaults = array(
        'delimiter' => '-',
        'limit' => null,
        'lowercase' => true,
        'transliterate' => true,
    );
 
    $options = array_merge($defaults, $options);
    $dmr = $defaults["delimiter"];
    $char_map = array(
        // Latin
        'À' => 'A', 'Á' => 'A', ' ' => $dmr, 'Ã' => 'A', 'Ä' => 'A', 'Å' => 'A', 'Æ' => 'AE', 'Ç' => 'C', 
        'È' => 'E', 'É' => 'E', 'Ê' => 'E', 'Ë' => 'E', 'Ì' => 'I', 'Í' => 'I', 'Î' => 'I', 'Ï' => 'I', 
        'Ð' => 'D', 'Ñ' => 'N', 'Ò' => 'O', 'Ó' => 'O', 'Ô' => 'O', 'Õ' => 'O', 'Ö' => 'O', 'Ő' => 'O', 
        'Ø' => 'O', 'Ù' => 'U', 'Ú' => 'U', 'Û' => 'U', 'Ü' => 'U', 'Ű' => 'U', 'Ý' => 'Y', 'Þ' => 'TH', 
        'ß' => 'ss', 
        'à' => 'a', 'á' => 'a', 'â' => 'a', 'ã' => 'a', 'ä' => 'a', 'å' => 'a', 'æ' => 'ae', 'ç' => 'c', 
        'è' => 'e', 'é' => 'e', 'ê' => 'e', 'ë' => 'e', 'ì' => 'i', 'í' => 'i', 'î' => 'i', 'ï' => 'i', 
        'ð' => 'd', 'ñ' => 'n', 'ò' => 'o', 'ó' => 'o', 'ô' => 'o', 'õ' => 'o', 'ö' => 'o', 'ő' => 'o', 
        'ø' => 'o', 'ù' => 'u', 'ú' => 'u', 'û' => 'u', 'ü' => 'u', 'ű' => 'u', 'ý' => 'y', 'þ' => 'th', 
        'ÿ' => 'y',
 
        // Latin symbols
        '©' => '(c)',
 
        // Greek
        'Α' => 'A', 'Β' => 'B', 'Γ' => 'G', 'Δ' => 'D', 'Ε' => 'E', 'Ζ' => 'Z', 'Η' => 'H', 'Θ' => '8',
        'Ι' => 'I', 'Κ' => 'K', 'Λ' => 'L', 'Μ' => 'M', 'Ν' => 'N', 'Ξ' => '3', 'Ο' => 'O', 'Π' => 'P',
        'Ρ' => 'R', 'Σ' => 'S', 'Τ' => 'T', 'Υ' => 'Y', 'Φ' => 'F', 'Χ' => 'X', 'Ψ' => 'PS', 'Ω' => 'W',
        'Ά' => 'A', 'Έ' => 'E', 'Ί' => 'I', 'Ό' => 'O', 'Ύ' => 'Y', 'Ή' => 'H', 'Ώ' => 'W', 'Ϊ' => 'I',
        'Ϋ' => 'Y',
        'α' => 'a', 'β' => 'b', 'γ' => 'g', 'δ' => 'd', 'ε' => 'e', 'ζ' => 'z', 'η' => 'h', 'θ' => '8',
        'ι' => 'i', 'κ' => 'k', 'λ' => 'l', 'μ' => 'm', 'ν' => 'n', 'ξ' => '3', 'ο' => 'o', 'π' => 'p',
        'ρ' => 'r', 'σ' => 's', 'τ' => 't', 'υ' => 'y', 'φ' => 'f', 'χ' => 'x', 'ψ' => 'ps', 'ω' => 'w',
        'ά' => 'a', 'έ' => 'e', 'ί' => 'i', 'ό' => 'o', 'ύ' => 'y', 'ή' => 'h', 'ώ' => 'w', 'ς' => 's',
        'ϊ' => 'i', 'ΰ' => 'y', 'ϋ' => 'y', 'ΐ' => 'i',
 
        // Turkish
        'Ş' => 'S', 'İ' => 'I', 'Ç' => 'C', 'Ü' => 'U', 'Ö' => 'O', 'Ğ' => 'G',
        'ş' => 's', 'ı' => 'i', 'ç' => 'c', 'ü' => 'u', 'ö' => 'o', 'ğ' => 'g', 
 
        // Russian
        'А' => 'A', 'Б' => 'B', 'В' => 'V', 'Г' => 'G', 'Д' => 'D', 'Е' => 'E', 'Ё' => 'Yo', 'Ж' => 'Zh',
        'З' => 'Z', 'И' => 'I', 'Й' => 'J', 'К' => 'K', 'Л' => 'L', 'М' => 'M', 'Н' => 'N', 'О' => 'O',
        'П' => 'P', 'Р' => 'R', 'С' => 'S', 'Т' => 'T', 'У' => 'U', 'Ф' => 'F', 'Х' => 'H', 'Ц' => 'C',
        'Ч' => 'Ch', 'Ш' => 'Sh', 'Щ' => 'Sh', 'Ъ' => '', 'Ы' => 'Y', 'Ь' => '', 'Э' => 'E', 'Ю' => 'Yu',
        'Я' => 'Ya',
        'а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'g', 'д' => 'd', 'е' => 'e', 'ё' => 'yo', 'ж' => 'zh',
        'з' => 'z', 'и' => 'i', 'й' => 'j', 'к' => 'k', 'л' => 'l', 'м' => 'm', 'н' => 'n', 'о' => 'o',
        'п' => 'p', 'р' => 'r', 'с' => 's', 'т' => 't', 'у' => 'u', 'ф' => 'f', 'х' => 'h', 'ц' => 'c',
        'ч' => 'ch', 'ш' => 'sh', 'щ' => 'sh', 'ъ' => '', 'ы' => 'y', 'ь' => '', 'э' => 'e', 'ю' => 'yu',
        'я' => 'ya',
 
        // Ukrainian
        'Є' => 'Ye', 'І' => 'I', 'Ї' => 'Yi', 'Ґ' => 'G',
        'є' => 'ye', 'і' => 'i', 'ї' => 'yi', 'ґ' => 'g',
 
        // Czech
        'Č' => 'C', 'Ď' => 'D', 'Ě' => 'E', 'Ň' => 'N', 'Ř' => 'R', 'Š' => 'S', 'Ť' => 'T', 'Ů' => 'U', 
        'Ž' => 'Z', 
        'č' => 'c', 'ď' => 'd', 'ě' => 'e', 'ň' => 'n', 'ř' => 'r', 'š' => 's', 'ť' => 't', 'ů' => 'u',
        'ž' => 'z', 
 
        // Polish
        'Ą' => 'A', 'Ć' => 'C', 'Ę' => 'e', 'Ł' => 'L', 'Ń' => 'N', 'Ó' => 'o', 'Ś' => 'S', 'Ź' => 'Z', 
        'Ż' => 'Z', 
        'ą' => 'a', 'ć' => 'c', 'ę' => 'e', 'ł' => 'l', 'ń' => 'n', 'ó' => 'o', 'ś' => 's', 'ź' => 'z',
        'ż' => 'z',
 
        // Latvian
        'Ā' => 'A', 'Č' => 'C', 'Ē' => 'E', 'Ģ' => 'G', 'Ī' => 'i', 'Ķ' => 'k', 'Ļ' => 'L', 'Ņ' => 'N', 
        'Š' => 'S', 'Ū' => 'u', 'Ž' => 'Z',
        'ā' => 'a', 'č' => 'c', 'ē' => 'e', 'ģ' => 'g', 'ī' => 'i', 'ķ' => 'k', 'ļ' => 'l', 'ņ' => 'n',
        'š' => 's', 'ū' => 'u', 'ž' => 'z'
    );
 
 
    if ($options['transliterate']) {
        $str = str_replace(array_keys($char_map), $char_map, $str);
    }
    $str = preg_replace('/[^\p{L}\p{Nd}]+/u', $options['delimiter'], $str);
    $str = preg_replace('/(' . preg_quote($options['delimiter'], '/') . '){2,}/', '$1', $str);
    $str = mb_substr($str, 0, ($options['limit'] ? $options['limit'] : mb_strlen($str, 'UTF-8')), 'UTF-8');
    $str = trim($str, $options['delimiter']);
    return $options['lowercase'] ? mb_strtolower($str, 'UTF-8') : $str;
}

function httpPost($url,$params,$referrer) { 
    $postData = '';
    foreach($params as $k => $v) {
        $postData .= $k . '='.$v; 
    } 
    rtrim($postData, '&'); 
 
	$Tarayici = 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0';
	
    $ch = curl_init(); 
	curl_setopt($ch, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4 );
    curl_setopt($ch, CURLOPT_URL,$url); 
	curl_setopt($ch, CURLOPT_USERAGENT, $Tarayici);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER,true); 
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch, CURLOPT_REFERER, $referrer);
    curl_setopt($ch, CURLOPT_HEADER, false); 
    curl_setopt($ch, CURLOPT_POST, count($postData));
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postData); 
	curl_setopt( $ch, CURLOPT_COOKIEJAR,  "cookie.txt" );
    curl_setopt( $ch, CURLOPT_COOKIEFILE, "cookie.txt" );
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 0);
    
    $output=curl_exec($ch); 

    curl_close($ch); 
    return $output; 
}

function VeriOku($Url,$Tarayici = false){ 

		if(!$Tarayici)
			$Tarayici = 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0';
	 
		$Curl = curl_init ();
		curl_setopt($Curl, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4 );
		curl_setopt($Curl, CURLOPT_URL, $Url);
		curl_setopt($Curl, CURLOPT_USERAGENT, $Tarayici);
		curl_setopt($Curl, CURLOPT_REFERER, 'https://www.pegem.net/');
		curl_setopt($Curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($Curl, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($Curl, CURLOPT_FOLLOWLOCATION, 0);
		curl_setopt($Curl, CURLOPT_ENCODING,  'gzip,deflate');
		curl_setopt($Curl, CURLOPT_COOKIEJAR,  "cookie.txt" );
		curl_setopt($Curl, CURLOPT_COOKIEFILE, "cookie.txt" );
		curl_setopt($Curl, CURLOPT_POSTREDIR, 3);
		$VeriOku = curl_exec ($Curl);
		curl_close($Curl);
		return str_replace(array("\n","\t","\r"), null, $VeriOku);
		 
}
	
public function avrupakitapdagitimbot($url)
{
		$Tarayici = "MozillaXYZ/1.0";
		$Site = $url;

		$searchsettingurl = "https://www.avrupakitapdagitim.com/processnaked.php?p=categoryfilter_output&ajax=true";
		
		$params = array( 
			"parameter" => "countlist__9999"
		);
		 
		$test = $this->httpPost($searchsettingurl,$params,$Site);

		$Kaynak = $this->VeriOku($Site,$Tarayici);
		
		$regexbooks = '<div class="listingProduct"><a onclick="psGTMProductClick(.*?)" href="(.*?)" title="(.*?)"></div>';
		$regexmanufacture = '<a href="(.*?)" property="item" typeof="Brand">                        <span property="name">(.*?)</span></a>';
		
		preg_match_all('@'.$regexbooks.'@',$Kaynak,$books);
		preg_match_all('@'.$regexmanufacture.'@',$Kaynak,$manufacture);

		$manufacturename = $manufacture[2][0];
		$this->kitapcek($books[2],$manufacturename);
	}
	
	function kitapcek($book,$manufacture)
	{
		$Tarayici = "MozillaXYZ/1.0";
		
		$regexwriter = '<strong>YAZAR:</strong>&nbsp;(.*?)&nbsp;';//
		$regexpagenumber = '<strong>SAYFA SAYISI:</strong>&nbsp;(.*?)&nbsp;';//
		$regexsize = '<strong>EBAT:</strong>&nbsp;(.*?)&nbsp;';
		$regexstock = '<span class="quantitytext">Adet</span>';//
		$regexsku = '<div class="detailProductCode">(.*?)</div>';//
		$regexcats = '<a href="(.*?)" property="item" typeof="Product">                        <span property="name">(.*?)</span></a>';//
		$regexprice = '<span id="pric">(.*?)</span> TL';//
		$regeximage = '<span id="DivImgSonuc_" style="position:relative;display:block;"><img src="(.*?)" class="product_imagesplaceholder" alt="(.*?)" id="Sonuc_"></span>';//
		$regextitle = '<div class="detailProductName"><span>(.*?)</span></div>';//
		$regexdescription = '<div class="tab_icerik">(.*?)</div>';//

		$addlicounter = 0;
		
		for($i = 0; $i < count($book); $i++)
		{
			$Kaynak = $this->VeriOku("https://www.avrupakitapdagitim.com/".$book[$i],$Tarayici);

			preg_match_all('@'.$regexstock.'@',$Kaynak,$stocks);
			preg_match_all('@'.$regeximage.'@',$Kaynak,$images);
			preg_match_all('@'.$regexwriter.'@',$Kaynak,$writer);
			preg_match_all('@'.$regexcats.'@',$Kaynak,$cats);
			preg_match_all('@'.$regexpagenumber.'@',$Kaynak,$pages);
			preg_match_all('@'.$regexprice.'@',$Kaynak,$prices);
			preg_match_all('@'.$regexsize.'@',$Kaynak,$sizes);
			preg_match_all('@'.$regexsku.'@',$Kaynak,$skus);
			preg_match_all('@'.$regextitle.'@',$Kaynak,$titles);
			preg_match_all('@'.$regexdescription.'@',$Kaynak,$descriptions);

			if(isset($skus[1][0])){ 
				$kitap['sku'] = html_entity_decode($skus[1][0]); 
				if (in_array($kitap['sku'], $this->products)) // eklenen verilerde varsa gösterme
					continue;
				else
					$addlicounter++;
			}
			else
				$kitap['sku'] = "";
			
			if(isset($writer[1][0])){ 
				$kitap['yazar'] = html_entity_decode($writer[1][0]); 
			}
			else
				$kitap['yazar'] = "";
			
			if(isset($pages[1][0])){ 
				$kitap['pagenumber'] = html_entity_decode($pages[1][0]); 
			}
			else
				$kitap['pagenumber'] = "";
			
			if(isset($sizes[1][0])){ 
				$kitap['ebat'] = html_entity_decode($sizes[1][0]); 
			}
			else
				$kitap['ebat'] = "";
			
			if(isset($stocks[0])){ 
				$kitap['stokdurumu'] = "Stokta";
			}
			else
				$kitap['stokdurumu'] = "Stokta Yok";
			
			if(isset($prices[1][1]) > 0){ 
				$kitap['fiyat'] = html_entity_decode($prices[1][1]); 
			}
			else
				$kitap['fiyat'] = "";
			
			if(count($cats[2]) > 0){ 
				$kitap['kategoriler'] = $cats[2];
			}
			else
				$kitap['kategoriler'] = "";
			
			if(isset($images[1][0]) > 0){
				$kitap['image'] = "https://www.avrupakitapdagitim.com/".$images[1][0]; 
			}
			else
				$kitap['image'] = "";
			
			if(isset($titles[1][0]) > 0){ 
				$kitap['title'] = html_entity_decode($titles[1][0]); 
			}
			else
				$kitap['title'] = "";
			
			if(isset($descriptions[1][0]) > 0){
				$kitap['description'] = $descriptions[1][0];
			}
			else
				$kitap['description'] = "";
			
			if(isset($manufacture)){ 
				$kitap['manufacture'] = html_entity_decode($manufacture); 
			}
			else
				$kitap['manufacture'] = "";
			
			if(empty($kitap['title']))
			{
				ob_flush();flush();
				continue;
			}
			
			echo '
									<tr id="'.$addlicounter.'">
										<td><input class="select" type="checkbox" name="selected[]" value=""></td>
										<td>'.$kitap['title'].'</td>
										<td><img class="aw-zoom" src="'.$kitap['image'].'" width="100" height="100"></td>
										<td>'.$kitap['fiyat'].' TL</td>
										<td>'.$kitap['fiyat'].' TL</td>
										<td>'.$kitap['sku'].'</td>
										<td>'.$kitap['stokdurumu'].'</td>
										<td>'.$kitap['ebat'].'</td>
										<td>'.$kitap['pagenumber'].'</td>
										<td>'.$kitap['yazar'].'</td>
										<td>
										';
										for($j = 0; $j < count($kitap['kategoriler']); $j++)
										{
											if(!empty($kitap['kategoriler'][$j]))
												echo $kitap['kategoriler'][$j].' , ';
											ob_flush();flush();
										}
										echo '</td>
										
										<td><select name="selectcategory" id="selectcategory">';
										for($j = 0; $j < count($this->categories); $j++)
											echo '<option value="'.$this->categories[$j]['category_id'].'">'.$this->categories[$j]['name'].'</option>';
										
										echo '
										</select></td>
										<td style="display: none;">'.$kitap['description'].'</td>
										<td style="display: none;">'.$kitap['manufacture'].'</td>
										<td style="display: none;">'.$kitap['yazar'].'</td>
										<td style="display: none;">'.$kitap['ebat'].'</td>
										<td style="display: none;">'.($kitap['stokdurumu'] == "Stokta" ? "100" : "0").'</td>
										<td style="display: none;">https://www.avrupakitapdagitim.com/'.$book[$i].'</td>
										<td><button id="add" name="add" onclick="add('.$addlicounter.');" class="btn btn-success" data-original-title="Kitabı Ekle"><i class="fa fa-plus"></i></button></td>
									</tr>
									';
			
			//array_push($this->booksarr,$kitap);
			ob_flush();flush();
		}
			
	}

}
	
?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if ($success) { ?>
        <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel">
            <div class="panel-heading">
                <h4 class="panel-title"><i class="fa fa-book"></i>Kitap Bilgisi Getir</h4>

            </div>
            <div class="panel-body">

                <div class="">
                    <div class="row">
                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-bot"
                              class="form-horizontal">
                            <div class="well">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="text-info lead">Site Ayarları</div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label"
                                                   for="input-url">Site Adresini Giriniz :<span
                                                        data-toggle="tooltip"
                                                        title="Verileri çekmesi için site adresini giriniz."></span></label>
                                            <div class="col-sm-6">
                                                <input type="text" name="url"
                                                       value="<?php if (isset($avrupakitapdagitimurl)) { echo $avrupakitapdagitimurl; }else{ echo 'https://www.avrupakitapdagitim.com/Akin-Dil-Yayinlari_br_474'; }?>"
                                                       placeholder="https://www.avrupakitapdagitim.com/Akin-Dil-Yayinlari_br_474" id="input-url"
                                                       class="form-control"/>
                                            </div>
											<div class="col-sm-2">
												<button type="submit" class="btn btn-success">Getir</button>
											</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
						</form>
					</div>
					
					
					
					<?php
					if(isset($avrupakitapdagitimurl))
					{
					?>
					<div class="row">
						<div id="ajaxsonuc" name="ajaxsonuc" class=""></div>
						<div class="">
						<a class="btn btn-info" name="allselect" id="allselect" data-toggle="tooltip" title="" data-original-title="Tüm Kitapları Seçer"><i class="fa fa-plus"></i> Hepsini Seç</a>
						<a class="btn btn-danger" name="alldeselect" id="alldeselect" data-toggle="tooltip" title="" data-original-title="Tüm Seçili Kitapları İptal Eder"><i class="fa fa-minus"></i> Seçilenleri İptal Et</a>
						<label class="control-label" for="allselectcategory">Hepsini Eklemek İçin Kategori Seçiniz</label>
						<select name="allselectcategory" id="allselectcategory" class="btn btn-info" >
									<?php
									for($i = 0; $i < count($categories); $i++)
										echo '<option value="'.$categories[$i]['category_id'].'">'.$categories[$i]['name'].'</option>';
									?>
                            </select>
						<div class="pull-right">
						
                            
							
							<a class="btn btn-success" onclick="allinsert()" data-toggle="tooltip" title="" data-original-title="Seçili tüm kitapları sisteme ekler"><i class="fa fa-book"></i> Seçililerin Hepsini Ekle</a>
						
						</div>
						
						</div>
						
						<div class="table-responsive">

						<table id="datatable1" class="table table-striped dt-responsive nowrap table-hover">
							<thead>
								<tr>
									<th>
										<strong>Seçiniz</strong>
									</th>
									<th class="text-left">
										<strong>Kitap Adı</strong>
									</th>
									<th class="text-left">
										<strong>Resim</strong>
									</th>
									<th class="text-left">
										<strong>İndirimsiz Fiyat</strong>
									</th>
									<th class="text-left">
										<strong>Güncel Fiyat</strong>
									</th>
									<th class="text-left">
										<strong>SKU</strong>
									</th>
									<th class="text-left">
										<strong>Stok Durumu</strong>
									</th>
									<th class="text-left">
										<strong>Ebat</strong>
									</th>
									<th class="text-left">
										<strong>Sayfa Sayısı</strong>
									</th>
									<th class="text-left">
										<strong>Yazar</strong>
									</th>
									<th class="text-left">
										<strong>Kategoriler</strong>
									</th>
									<th class="text-left">
										<strong>Kayıt Edilecek Kategori</strong>
									</th>
									<td class="text-right">Eylem</td>
								</tr>
							</thead>
							<tbody>
							
							<?php
							if (isset($avrupakitapdagitimurl)) { 
								$Bot = new BKBOT($categories,$product);
								$Bot->avrupakitapdagitimbot($avrupakitapdagitimurl);
							}
							?>
							
							</tbody>
						</table>
					
						</div>
					
					</div>
					
					<?php } ?>
					
				</div>
			</div>
		</div>
	</div>
</div>

<style>
.aw-zoom
{
    position: relative;
    -webkit-transform: scale(1);
    -ms-transform: scale(1);
    -moz-transform: scale(1);
    transition: all .3s ease-in;
    -moz-transition: all .3s ease-in;
    -webkit-transition: all .3s ease-in;
    -ms-transition: all .3s ease-in;
}

.aw-zoom:hover
{
    z-index:2;
    -webkit-transform: scale(3);
    -ms-transform: scale(3);  
    -moz-transform: scale(3);
    transform: scale(3);
}
</style>

<script type="text/javascript">
    $('#allselect').on('click', function() {
		$(':checkbox').prop('checked','checked');
    });
	$('#alldeselect').on('click', function() {
		$(':checkbox').prop('checked','');
    });
	
	$('#allselectcategory').change(function() {
		var index = $(this)[0].selectedIndex;
		var e = document.getElementsByTagName("select");
		for (var i = 1; i < e.length; i++)
			e[i].selectedIndex = index;
	});
	
	function add(id)
	{
		var tr = $("#datatable1")[0];
		var row = tr.rows[id];
		debugger;
		gonder(row,id);
	}
	
	async function allinsert()
	{
		var tr = $("#datatable1")[0];
		
		for (var i = 1; i < tr.rows.length; i++)
		{
			var row = tr.rows[i];
			var selected = row.children[0];
			if(selected.children.length == 0)
				continue;
			
			var sc = selected.children[0].checked;
			if(sc){
				gonder(row,i);
				await wait(2500);
			}
		}
	}
	
	function wait(time) {
		return new Promise(resolve => {
			setTimeout(() => {
				resolve();
			}, time);
		});
	}
	
	function gonder(datas,indexs)
	{
		var slctd = datas.children[0];
		var name = datas.children[1].innerText;
		var sku = datas.children[5].innerText;
		var quantity = datas.children[16].innerText;
		var price = datas.children[3].innerText;
		var priceindirim = datas.children[4].innerText;
		var pagenumber = datas.children[8].innerText;
		var cat = datas.children[11].childNodes[0].value;
		var description = datas.children[12].innerHTML;
		var manufacture = datas.children[13].innerText;
		var upc = datas.children[14].innerText;
		var jan = datas.children[15].innerText;
		var image = datas.children[2].children[0].src;
		var eslestirme = datas.children[17].innerText;
		
		var button = datas.children[18];
		
		
		var formData = {
            'name': name,
			'sku': sku,
			'price': price,
			'priceindirim': priceindirim,
			'pagenumber': pagenumber,
			'cat': cat,
			'description': description,
			'manufacturers': manufacture,
			'upc': upc,
			'jan': jan,
			'image': image,
			'quantity' : quantity,
			'eslestirme' : eslestirme
        };
	    
		var user_token ='<?php echo $user_token; ?>';
		
		var sonuc = false;
		
		$.ajax({
            type: "POST",
            url: 'index.php?route=kitapcek/avrupakitapdagitim/kitapekle&user_token=' + user_token,
            data: formData,
            success: function (data) {
				var sonuc = data;
                $('#ajaxsonuc')[0].innerHTML += sonuc;
				button.innerHTML = '<td><button id="delete" name="delete" class="btn btn-danger">Eklendi</button></td>';
				slctd.innerHTML = '<td></td>';
				sonuc = true;
            }
        });
		
		return sonuc;
	}
	
</script>