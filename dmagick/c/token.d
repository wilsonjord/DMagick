module dmagick.c.token;

import dmagick.c.magickType;
import dmagick.c.magickVersion;

extern(C)
{
	struct TokenInfo {}

	int Tokenizer(TokenInfo*, const uint, char*, const size_t, const(char)*,
			const(char)*, const(char)*, const(char)*, const char, char*, int*, char*);

	MagickBooleanType GlobExpression(const(char)*, const(char)*, const MagickBooleanType);
	MagickBooleanType IsGlob(const(char)*);
	MagickBooleanType IsMagickTrue(const(char)*);

	TokenInfo* AcquireTokenInfo();
	TokenInfo* DestroyTokenInfo(TokenInfo*);

	static if ( MagickLibVersion < 0x694 )
	{
		void GetMagickToken(const(char)*, const(char)**, char*);
	}

	static if ( MagickLibVersion >= 0x694 )
	{
		void GetNextToken(const(char)*, const(char)**, const size_t, char*);
	}
}
