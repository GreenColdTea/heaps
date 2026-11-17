package hxd;

class Charset {

	/**
		Contains the whole ASCII charset.
	**/
	public static var ASCII = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";

	/**
		The Latin1 (ISO 8859-1) charset (only the extra chars, no the ASCII part) + euro symbol
	**/
	public static var LATIN1 = "¡¢£¤¥¦§¨©ª«¬-®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿœæŒÆ€";

	/**
		Central/Eastern European, Baltic, Romanian & typography symbols
	**/
	public static var LATIN_EXTENDED = "ĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĲĳĴĵĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇňŉŊŋŌōŎŏŐőŒœŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽžȘșȚțʻ«»„“”‘’–—…•№™";

	/**
		Cyrillic support
	**/
	public static var CYRILLIC = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюяҐЄІЇЎҚҒҲӘӨҮҰҢҺҖҘҠҪЂЈЉЊЋЏЃЅЌӢӮҶҸҜӐӖӲӇґєіїўқғҳәөүұңһҗҙҡҫђјљњћџѓѕќӣӯҷҹҝӑӗӳӈ—";

	/**
		Polish support
	**/
	public static var POLISH = "ĄĆĘŁŃÓŚŹŻąćęłńóśźż";

	/**
		Turkish support
	**/
	public static var TURKISH = "ÂÇĞIİÎÖŞÜÛâçğıİîöşüû";

	/**
		Contains Hiragana, Katanaga, japanese punctuaction and full width space (0x3000) full width numbers (0-9) and some full width ascii punctuation (!:?%&()-). Does not include full width A-Za-z.
	**/
	public static var JP_KANA = " あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわゐゑをんがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽゃゅょアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヰヱヲンガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポヴャぇっッュョァィゥェォ・ー「」、。『』“”！：？％＆（）－０１２３４５６７８９";

	/**
		Special unicode chars (fallback chars)
	**/
	public static var UNICODE_SPECIALS = "□";

	public static var DEFAULT_CHARS = ASCII + LATIN1 + LATIN_EXTENDED + CYRILLIC + POLISH + TURKISH + JP_KANA + UNICODE_SPECIALS;

	var map : Map<Int,Int>;

	function new() {
		map = new Map();
		inline function m(a:Int, b:Int) {
			map.set(a, b);
		}
		inline function mapAll(chars:String, target:Int) {
			for (i in 0...chars.length)
				map.set(chars.charCodeAt(i), target);
		}

		// fullwidth unicode to ASCII (if missing)
		for( i in 0...0x5E )
			m(0xFF01 + i, 0x21 + i);
		// Latin1 accents
		for( i in "À".code..."Æ".code + 1 )
			m(i, "A".code);
		for( i in "à".code..."æ".code + 1 )
			m(i, "a".code);
		for( i in "È".code..."Ë".code + 1 )
			m(i, "E".code);
		for( i in "è".code..."ë".code + 1 )
			m(i, "e".code);
		for( i in "Ì".code..."Ï".code + 1 )
			m(i, "I".code);
		for( i in "ì".code..."ï".code + 1 )
			m(i, "i".code);
		for( i in "Ò".code..."Ö".code + 1 )
			m(i, "O".code);
		for( i in "ò".code..."ö".code + 1 )
			m(i, "o".code);
		for( i in "Ù".code..."Ü".code + 1 )
			m(i, "U".code);
		for( i in "ù".code..."ü".code + 1 )
			m(i, "u".code);
		m("Ç".code, "C".code);
		m("ç".code, "c".code);
		m("Ð".code, "D".code);
		m("Þ".code, "d".code);
		m("Ñ".code, "N".code);
		m("ñ".code, "n".code);
		m("Ý".code, "Y".code);
		m("ý".code, "y".code);
		m("ÿ".code, "y".code);
		m("€".code, "E".code);
		// Extended Latin
		mapAll("ĀĂĄ", "A".code);
		mapAll("āăą", "a".code);
		mapAll("ĆĈĊČ", "C".code);
		mapAll("ćĉċč", "c".code);
		mapAll("ĎĐ", "D".code);
		mapAll("ďđ", "d".code);
		mapAll("ĒĔĖĘĚ", "E".code);
		mapAll("ēĕėęě", "e".code);
		mapAll("ĜĞĠĢ", "G".code);
		mapAll("ĝğġģ", "g".code);
		mapAll("ĤĦ", "H".code);
		mapAll("ĥħ", "h".code);
		mapAll("ĨĪĬĮİ", "I".code);
		mapAll("ĩīĭįı", "i".code);
		m("Ĵ".code, "J".code);
		m("ĵ".code, "j".code);
		m("Ķ".code, "K".code);
		m("ķ".code, "k".code);
		mapAll("ĹĻĽĿŁ", "L".code);
		mapAll("ĺļľŀł", "l".code);
		mapAll("ŃŅŇŊ", "N".code);
		mapAll("ńņňŋ", "n".code);
		mapAll("ŌŎŐ", "O".code);
		mapAll("ōŏő", "o".code);
		mapAll("ŔŖŘ", "R".code);
		mapAll("ŕŗř", "r".code);
		mapAll("ŚŜŞŠȘ", "S".code);
		mapAll("śŝşšș", "s".code);
		mapAll("ŢŤŦȚ", "T".code);
		mapAll("ţťŧț", "t".code);
		mapAll("ŨŪŬŮŰŲ", "U".code);
		mapAll("ũūŭůűų", "u".code);
		m("Ŵ".code, "W".code);
		m("ŵ".code, "w".code);
		mapAll("ŶŸ", "Y".code);
		m("ŷ".code, "y".code);
		mapAll("ŹŻŽ", "Z".code);
		mapAll("źżž", "z".code);
		m("ʻ".code, "'".code);
		// Cyrillic
		mapAll("ӘӐ", "А".code);
		mapAll("әӑ", "а".code);
		mapAll("ҒҐЃҜ", "Г".code);
		mapAll("ғґѓҝ", "г".code);
		m("Ђ".code, "Д".code);
		m("ђ".code, "д".code);
		mapAll("ЁЄӖ", "Е".code);
		mapAll("ёєӗ", "е".code);
		mapAll("ҖҶҸЏ", "Ж".code);
		mapAll("җҷҹџ", "ж".code);
		mapAll("ҘЅ", "З".code);
		mapAll("ҙѕ", "з".code);
		m("Ӣ".code, "И".code);
		m("ӣ".code, "и".code);
		mapAll("ІЇ", "I".code);
		mapAll("ії", "i".code);
		m("Ј".code, "J".code);
		m("ј".code, "j".code);
		mapAll("ҚҠЌ", "К".code);
		mapAll("қҡќ", "к".code);
		m("Љ".code, "Л".code);
		m("љ".code, "л".code);
		mapAll("ҢЊӇ", "Н".code);
		mapAll("ңњӈ", "н".code);
		m("Ө".code, "О".code);
		m("ө".code, "о".code);
		m("Ҫ".code, "С".code);
		m("ҫ".code, "с".code);
		m("Ћ".code, "Т".code);
		m("ћ".code, "т".code);
		mapAll("ЎҮҰӮӲ", "У".code);
		mapAll("ўүұӯӳ", "у".code);
		mapAll("ҲҺ", "Х".code);
		mapAll("ҳһ", "х".code);
		// unicode spaces
		m(0x3000, 0x20); // full width space
		m(0xA0, 0x20); // nbsp
		// unicode quotes & dashes
		m("«".code, '"'.code);
		m("»".code, '"'.code);
		m("“".code, '"'.code);
		m("”".code, '"'.code);
		m("„".code, '"'.code);
		m("‘".code, "'".code);
		m("’".code, "'".code);
		m("´".code, "'".code);
		m("‹".code, "<".code);
		m("›".code, ">".code);
		m("–".code, "-".code);
		m("—".code, "-".code);
	}

	public function resolveChar<T>( code : Int, glyphs : Map<Int,T> ) : Null<T> {
		var c : Null<Int> = code;
		while( c != null ) {
			var g = glyphs.get(c);
			if( g != null ) return g;
			c = map.get(c);
		}
		return null;
	}

	public function isCJK(code) {
		#if accurate_cjk_detection
		return (code >= 0x2E80 && code <= 0x2FFF) ||
					 (code >= 0x3040 && code <= 0x309F) ||
					 (code >= 0x30A0 && code <= 0x30FF) ||
					 (code >= 0x3400 && code <= 0x4DBF) ||
					 (code >= 0x4E00 && code <= 0x9FFF) ||
					 (code >= 0xF900 && code <= 0xFAFF) ||
					 (code >= 0xA000 && code <= 0xA48F) ||
					 (code >= 0xA490 && code <= 0xA4CF) ||
					 (code >= 0xFE64 && code <= 0xFE66) ||
					 (code >= 0xFF01 && code <= 0xFF5A) ||
					 (code >= 0x20000 && code <= 0x3FFFD);
		#else
		return (code >= 0x2E80 && code <= 0xA4CF) || (code >= 0xF900 && code <= 0xFAFF) || (code >= 0x20000 && code <= 0x3FFFD);
		#end
	}

	public function isSpace(code) {
		return code == ' '.code || code == 0x3000;
	}

	public function isBreakChar(code) {
		return isSpace(code) || isCJK(code);
	}

	static var complementChars : Map<Int,Bool> = {
		var str = "ヽヾーァィゥェォッャュョヮヵヶぁぃぅぇぉっゃゅょゎゕゖㇰㇱㇲㇳㇴㇵㇶㇷㇸㇹㇺㇻㇼㇽㇾㇿ々〻。，、；：！？";
		[for( i in 0...str.length ) str.charCodeAt(i) => true];
	}

	public function isComplementChar(code) {
		return complementChars.exists(code);
	}

	static var inst : Charset;
	public static function getDefault() {
		if( inst == null ) inst = new Charset();
		return inst;
	}
}