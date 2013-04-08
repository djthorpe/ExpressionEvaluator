
enum {
	PGParserKWState = 1000,
	PGParserKWDefault,
	PGParserKWError,
	PGParserKWAction,
	PGParserKWPush,
	PGParserKWPop,
	PGParserKWEmpty,
	PGParserDecimal,
	PGParserHash,
	PGParserIdentifier,
	PGParserComma,
	PGParserSemicolon,
	PGParserOpenBrace,
	PGParserCloseBrace,
	PGParserWhitespace,
	PGParserNewline,
	PGParserOther
};
