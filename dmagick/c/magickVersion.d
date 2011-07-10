module dmagick.c.magickVersion;

extern(C)
{
	/// Defines the version of ImageMagick where these headers are based on.
	enum MagickLibVersion = 0x671;
	///ditto
	enum MagickLibVersionText = "6.7.1"; 

	char* GetMagickHomeURL();

	const(char)* GetMagickCopyright();
	const(char)* GetMagickFeatures();
	const(char)* GetMagickPackageName();
	const(char)* GetMagickQuantumDepth(size_t*);
	const(char)* GetMagickQuantumRange(size_t*);
	const(char)* GetMagickReleaseDate();
	const(char)* GetMagickVersion(size_t*);
}
