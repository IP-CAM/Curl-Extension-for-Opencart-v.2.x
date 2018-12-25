<?php 

class ControllerKitapcekAvrupakitapdagitim extends Controller{
	
	private$error=array();
	
	public function index(){
	
			$this->language->load("kitapcek/avrupakitapdagitim");
			$this->load->model("setting/setting");
			
			if(isset($this->session->data["success"])){
				$data["success"]=$this->session->data["success"];
				unset($this->session->data["success"]);
			}else{
				$data["success"]="";
			}
			
			$data["action"]=$this->url->link("kitapcek/avrupakitapdagitim","user_token=".$this->session->data["user_token"],"SSL");

			$data["heading_title"]=$this->language->get("heading_title");
			$data["text_edit"]=$this->language->get("text_edit");
			$data["button_save"]=$this->language->get("text_button_save");
			$data["button_cancel"]=$this->language->get("text_button_cancel");
			$data["breadcrumbs"]=array();
			$data["breadcrumbs"][]=array("text"=>$this->language->get("text_home"),"href"=>$this->url->link("common/dashboard","user_token=".$this->session->data["user_token"],"SSL"));
			$data["breadcrumbs"][]=array("text"=>$this->language->get("page_title"),"href"=>$this->url->link("kitapcek/avrupakitapdagitim","user_token=".$this->session->data["user_token"],"SSL"));
			$data["user_token"]=$this->session->data["user_token"];
			
			if(isset($this->error["warning"])){
				$data["error_warning"]=$this->error["warning"];
			}else{
				$data["error_warning"]="";
			}
			
			
			$this->load->model('catalog/category');
			
			$filter_data = array();
			$results = $this->model_catalog_category->getCategories($filter_data);

			foreach ($results as $result) {
				$data['categories'][] = array(
					'category_id' => $result['category_id'],
					'name'        => $result['name']
				);
			}
	
	
			if(($this->request->server["REQUEST_METHOD"]=="POST")&&$this->validate()){
				//$this->session->data["success"]=$this->language->get("text_success");
				if(isset($this->request->post["url"])){
					$data['avrupakitapdagitimurl'] = $this->request->post['url'];
					
					$data['product'] = array();
					
					$query = $this->allproductgetisbn();
					for($i = 0; $i < $query->num_rows; $i++)
						$data['product'][$i] = $query->rows[$i]['sku'];
				}
			}
			
			$data["header"]=$this->load->controller("common/header");
			$data["column_left"]=$this->load->controller("common/column_left");
			$data["footer"]=$this->load->controller("common/footer");
			
			$this->config->set('template_engine', 'template');	
			$this->response->setOutput($this->load->view("kitapcek/avrupakitapdagitim",$data));
	}
	
	protected function validate(){
		
		if(!$this->user->hasPermission("modify","kitapcek/avrupakitapdagitim")){
			$this->error["warning"]=$this->language->get("error_permission");
		}
		
		return!$this->error;
	}
					
					
	public function install(){
	
  
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
	
	public function lastinsertmodelid()
	{
		$sql = "SELECT p.model FROM " . DB_PREFIX . "product as p ORDER BY p.model DESC limit 0,1";
		$query = $this->db->query($sql);
		foreach ($query->rows as $result)
			return $result['model'];
		return 0;
	}
	
	public function searchproductbyisbn($sku)
	{
		$sql = "SELECT p.model FROM " . DB_PREFIX . "product as p WHERE p.sku = '$sku' or p.isbn = '$sku'";
		$query = $this->db->query($sql);
		foreach ($query->rows as $result)
			return true;
		return false;
	}
	
	public function allproductgetisbn()
	{
		$sql = "SELECT sku FROM " . DB_PREFIX . "product WHERE sku <> ''";
		$query = $this->db->query($sql);
		return $query;
	}
	
	public function eslestirmeinsertbyid($sku,$eslestirme)
	{
		$sql = "UPDATE " . DB_PREFIX . "product SET eslestirme = '$eslestirme' WHERE sku = '$sku'";
		$query = $this->db->query($sql);
	}
	
	function tr_strtolower($text)
	{
		$search=array("Ç","İ","I","Ğ","Ö","Ş","Ü");
		$replace=array("ç","i","ı","ğ","ö","ş","ü");
		$text=str_replace($search,$replace,$text);
		$text=strtolower($text);
		return $text;
	}
	
	public function kitapekle()
	{
		if(($this->request->server["REQUEST_METHOD"]=="POST")&&$this->validate()){
			$this->session->data["success"]=$this->language->get("add_text_success");

			$productname = $this->request->post["name"];
			$cat = $this->request->post["cat"];
			$sku = $this->request->post["sku"];
			$upc = $this->request->post["upc"];
			$jan = $this->request->post["jan"];
			$price = $this->request->post["price"];
			$priceindirim = $this->request->post["priceindirim"];
			$pagenumber = $this->request->post["pagenumber"];
			$manufacturersname = $this->request->post["manufacturers"];
			$imagelink = $this->request->post["image"];
			$description = $this->request->post["description"];
			$quantity = $this->request->post["quantity"];
			$eslestirme = $this->request->post["eslestirme"];
			
			$price = str_replace(',','.',$price);
			$price = floatval($price);
			$priceindirim = str_replace(',','.',$priceindirim);
			$priceindirim = floatval($priceindirim);

			$productname = $this->tr_strtolower($productname);
			$manufacturersname = $this->tr_strtolower($manufacturersname);
			$productname = preg_replace('/'.$manufacturersname.'/', '', $productname); 
			$productname .= " ".$manufacturersname;
			
			$productname = ucwords($productname);
			$manufacturersname = ucwords($manufacturersname);

			if($this->searchproductbyisbn($sku)){
				echo '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> '.$productname.' Kitabı Zaten Mevcut ! <b>ISBN : '.$sku.'</b><button type="button" class="close" data-dismiss="alert">&times;</button></div>';
				die();
			}
			
			$manufacturers = 0;

			// Load model into memory if it isn't already
			$this->load->model('catalog/manufacturer');
			
			$filter_data = array(
				'filter_name' => $manufacturersname,
				'order' => 'DESC'
			);
			
			$results = $this->model_catalog_manufacturer->getManufacturers($filter_data);

			$urls = "";
			
			foreach ($results as $result) {
				$manufacturers = $result['manufacturer_id'];
				$urls = $this->url_seo($manufacturersname);
			}
			
			if(count($results) == 0) /* yayınevi yoksa oluştur */
			{
				$urls = $this->url_seo($manufacturersname);

				$manufacturer = array();
				$manufacturer[0][1] = $urls;
				$manufacturer[1]['description'] = ' ';
				$manufacturer[1]['custom_title'] = ' ';
				$manufacturer[1]['meta_description'] = ' ';
				$manufacturer[1]['meta_keyword'] = ' ';
				
				$manufacturestore = array();
				$manufacturestore[0] = '0';
				$manufacturestore[1] = '0';
				
				$manufacturesim = "catalog/".$urls."/".$urls.'.png';
					
				$data = array(
					'name' => $manufacturersname,
					'manufacturer_store' => $manufacturestore,
					'manufacturer_seo_url' => $manufacturer,
					'sort_order' => 0,
					'image' => $manufacturesim,
					'manufacturer_description' => array()
				);
				
				$manufacturers = $this->model_catalog_manufacturer->addManufacturer($data);
			}
			
			$date = date('Y-m-d');
			$datetime = date('Y-m-d H:i:s');
			
			/* oc_product_description */
			$productdescription = array();
			$productdescription[1]['video'] = '';
			$productdescription[1]['tab_title'] = '';
			$productdescription[1]['html_product_tab'] = '';
			$productdescription[1]['meta_title'] = $productname;
			$productdescription[1]['name'] = $productname;
			$productdescription[1]['description'] = $description;
			$productdescription[1]['tag'] = $productname;
			$productdescription[1]['meta_description'] = $productname;
			$productdescription[1]['meta_keyword'] = $productname;
			/* oc_product_description_seo */
			$productdescription[1]['custom_h1'] = '';
			$productdescription[1]['custom_h2'] = '';
			$productdescription[1]['custom_imgtitle'] = '';
			$productdescription[1]['custom_alt'] = '';
			/* indirim */
			$product_special = array();
			$product_special[0]['customer_group_id'] = '1';//bireysel
			$product_special[0]['priority'] = '0';
			$product_special[0]['price'] = $priceindirim - ($priceindirim * 8 / 100);
			$product_special[0]['date_start'] = '';
			$product_special[0]['date_end'] = '';
			
			/* image download */
			$imageseo = $sku.".png";
			$image_folder = 'catalog/'.$urls;
			$this->file_download($imagelink,$imageseo,DIR_IMAGE.$image_folder);
			
			/* Store */
			$product_store = array(0);
			
			$soneklenenid = intval($this->lastinsertmodelid() + 1);

			// Assoc array of data
			$productData = array(
				'name' => $productname,
				'product_category' => array($cat),
				'sku'	=> $sku,
				'upc'	=> $upc,
				'ean'	=> $pagenumber,
				'jan'	=> $jan,
				'isbn'	=> '',
				'mpn'	=> '',
				'location'	=> '',
				'quantity'	=> $quantity,
				'model' => $soneklenenid,
				'manufacturer_id' => $manufacturers,
				'product_description' => $productdescription,
				'image'	=> $image_folder."/".$imageseo,
				'shipping'	=> 1,
				'price'	=> $price - ($price * 8 / 100),
				'points'	=> 0,
				'date_added'	=> $datetime,
				'date_modified'	=> $datetime,
				'date_available'=> $date,
				'weight'	=> 0.00,
				'weight_unit'	=> 'kg',
				'weight_class_id'	=> 1,
				'length'	=> 0.00,
				'length_class_id'	=> 1,
				'width'	=> 0.00,
				'height'	=> 0.00,
				'length_unit'	=> 'cm',
				'status'	=> true,
				'tax_class_id'	=> 2,
				'stock_status_id'	=> 2,
				'store_ids'		=> $product_store,
				'product_store' => $product_store,
				'product_special' => $product_special,
				'layout'		=> '',
				'related_ids'	=> '',
				'sort_order'	=> 1,
				'subtract'	=> true,
				'minimum'	=> 1
			);
			
			// Load model into memory if it isn't already
			$this->load->model('catalog/product');

			// Attempt to pass the assoc array to the add Product method
			$this->model_catalog_product->addProduct($productData);
			
			$this->eslestirmeinsertbyid($sku,$eslestirme);
			
			echo '<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> '.$productname.' Kitabı Eklendi ! <b>ISBN : '.$sku.'</b><button type="button" class="close" data-dismiss="alert">&times;</button></div>';;
		}
	}
	
}

?>