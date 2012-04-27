Message-ID: <4F9A5EB7.902@...515...>
Date: Fri, 27 Apr 2012 11:54:15 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
	<1332621070-28464-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332621070-28464-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: windows: convert argv (UCS-2
 to UTF-8) at earliest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

As promised in yesterday's IRC meeting (summary coming today), I tested
this patch on Windows 7 (64-bit). So far I've had no luck, but don't
think the problems have anything to do with this patch.

Anyways, I cross-compiled latest "master" with this patch applied and
"bin" and "lib" directories on top of an existing openvpn-2.3-alpha1
install. The old "bin" directory was renamed to make sure none of it was
used. I then renamed "openvpn.ovpn" to "=E4=E4li=F6.ovpn" and "ta.key" to
"=E4=E4li=F6.key" using Windows Explorer. Then I updated the configuration
file to point to these files using Notepad (and later Wordpad).

OpenVPN-GUI (Heiko's new version) detected the configuration file
properly, showing "=E4=E4li=F6" as one available connection option. However,
it output the following when trying to connect:

    Options error: --tls-auth fails with '=E4=E4li=F6.key': No such file or
directory

Git Bash showed the file as ??li?.key, which could mean Windows Explorer
is using a single-byte character set.

Windows command prompt shows the characters properly, but issuing
"openvpn --config =E4=E4li=F6.ovpn" gives the same error as OpenVPN-GUI abo=
ve,
except that '=E4=E4li=F6.key' shows faulty glyphs[1]. This also triggers an
interesting bug in the command prompt[2]

Anyways, as the Windows 7 install is English-language, I suspect it's
using a single-byte character set instead of UCS-2. I'll continue
debugging, but any pointers are obviously much appreciated!

Samuli

[1] <http://users.utu.fi/sjsepp/cmd.png>
[2] Typing an "=E4" or "=F6" moves the (invisible) cursor forward one
character, but each backspace will delete two characters instead of one.
This does not happen until openvpn has been (unsuccessfully) started.


> Discussed at [1].
>
> Use wmain under windows, drop the custom parsing and shell32 linkage.
>
> There is no need for gc magic as this allocation is static.
>
> [1] http://permalink.gmane.org/gmane.network.openvpn.devel/5433
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/Makefile.am     |    6 +++++-
>  src/openvpn/openvpn.c       |   37 ++++++++++++++++++++++++++++++++++++-
>  src/openvpn/openvpn.vcxproj |   10 ++++++----
>  src/openvpn/options.c       |   27 ---------------------------
>  4 files changed, 47 insertions(+), 33 deletions(-)
>  mode change 100644 =3D> 100755 src/openvpn/openvpn.vcxproj
>
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 4e485e7..0506b11 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -27,6 +27,10 @@ AM_CFLAGS =3D \
>  	$(OPTIONAL_CRYPTO_CFLAGS) \
>  	$(OPTIONAL_LZO_CFLAGS) \
>  	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
> +if WIN32
> +# we want unicode entry point but not the macro
> +AM_CFLAGS +=3D -municode -UUNICODE
> +endif
>=20=20
>  sbin_PROGRAMS =3D openvpn
>=20=20
> @@ -118,5 +122,5 @@ openvpn_LDADD =3D \
>  	$(OPTIONAL_DL_LIBS)
>  if WIN32
>  openvpn_SOURCES +=3D openvpn_win32_resources.rc
> -openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwin=
mm -lshell32
> +openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwin=
mm
>  endif
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index 3db1b86..6e70a58 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -127,8 +127,9 @@ tunnel_point_to_point (struct context *c)
>   * @param argc - Commandline argument count.
>   * @param argv - Commandline argument values.
>   */
> +static
>  int
> -main (int argc, char *argv[])
> +openvpn_main (int argc, char *argv[])
>  {
>    struct context c;
>=20=20
> @@ -289,3 +290,37 @@ main (int argc, char *argv[])
>    openvpn_exit (OPENVPN_EXIT_STATUS_GOOD);  /* exit point */
>    return 0;			            /* NOTREACHED */
>  }
> +
> +#ifdef WIN32
> +int
> +wmain (int argc, wchar_t *wargv[]) {
> +  char **argv;
> +  int ret;
> +  int i;
> +
> +  if ((argv =3D calloc(argc+1, sizeof(char*))) =3D=3D NULL)
> +    return 1;
> +
> +  for (i =3D 0; i < argc; i++)
> +    {
> +      int n =3D WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, NULL, 0, =
NULL, NULL);
> +      argv[i] =3D malloc (n);
> +      WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, argv[i], n, NULL, N=
ULL);
> +    }
> +
> +  ret =3D openvpn_main(argc, argv);
> +
> +  for (i=3D0; i < argc; i++ )
> +    {
> +      free (argv[i]);
> +    }
> +  free(argv);
> +
> +  return ret;
> +}
> +#else
> +int
> +main (int argc, char *argv[]) {
> +	return openvpn_main(argc, argv);
> +}
> +#endif
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> old mode 100644
> new mode 100755
> index 51e19af..452876f
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -18,12 +18,12 @@
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Relea=
se|Win32'" Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
> -    <CharacterSet>MultiByte</CharacterSet>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
> +    <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|Win32'" Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
> -    <CharacterSet>MultiByte</CharacterSet>
> +    <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
>    <ImportGroup Label=3D"ExtensionSettings">
> @@ -56,12 +56,13 @@
>        </PrecompiledHeader>
>        <WarningLevel>Level3</WarningLevel>
>        <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
> +      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefi=
nitions>
>      </ClCompile>
>      <ResourceCompile>
>        <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
>      </ResourceCompile>
>      <Link>
> -      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDependencies>
> +      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
>        <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;=
$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirec=
tories>
>        <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> @@ -80,12 +81,13 @@
>        </PrecompiledHeader>
>        <WarningLevel>Level3</WarningLevel>
>        <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefi=
nitions>
>      </ClCompile>
>      <ResourceCompile>
>        <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
>      </ResourceCompile>
>      <Link>
> -      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDependencies>
> +      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
>        <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;=
$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirec=
tories>
>        <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 25786f6..66241b4 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3832,33 +3832,6 @@ parse_argv (struct options *options,
>  {
>    int i, j;
>=20=20
> -#ifdef WIN32
> -  /*
> -   * Windows replaces Unicode characters in argv[] that are not present
> -   * in the current codepage with '?'. Get the wide char command line and
> -   * convert it to UTF-8 ourselves.
> -   */
> -  int wargc;
> -  WCHAR **wargv;
> -  char **uargv;
> -
> -  wargv =3D CommandLineToArgvW (GetCommandLineW (), &wargc);
> -  if (wargv =3D=3D NULL || wargc !=3D argc)
> -    usage ();
> -
> -  uargv =3D gc_malloc (wargc * sizeof (*uargv), false, &options->gc);
> -
> -  for (i =3D 0; i < wargc; i++)
> -    {
> -      int n =3D WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, NULL, 0, =
NULL, NULL);
> -      uargv[i] =3D gc_malloc (n, false, &options->gc);
> -      WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, uargv[i], n, NULL, =
NULL);
> -    }
> -
> -  LocalFree (wargv);
> -  argv =3D uargv;
> -#endif
> -
>    /* usage message */
>    if (argc <=3D 1)
>      usage ();


