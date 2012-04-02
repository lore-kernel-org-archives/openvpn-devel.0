MIME-Version: 1.0
In-Reply-To: <1332621070-28464-1-git-send-email-alon.barlev@...277...>
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
	<1332621070-28464-1-git-send-email-alon.barlev@...277...>
Date: Mon, 2 Apr 2012 14:39:04 +0300
Message-ID: <CAOazyz1_8+ViUgPs5ECD2MroH33Zmp0Y0Q3VMEyBvhhVHE5Jcw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Please review/test.

On Sat, Mar 24, 2012 at 10:31 PM, Alon Bar-Lev <alon.barlev@...277...> wrot=
e:
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
> =C2=A0src/openvpn/Makefile.am =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +++++-
> =C2=A0src/openvpn/openvpn.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 37 ++++++++++++=
++++++++++++++++++++++++-
> =C2=A0src/openvpn/openvpn.vcxproj | =C2=A0 10 ++++++----
> =C2=A0src/openvpn/options.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 27 ------------=
---------------
> =C2=A04 files changed, 47 insertions(+), 33 deletions(-)
> =C2=A0mode change 100644 =3D> 100755 src/openvpn/openvpn.vcxproj
>
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 4e485e7..0506b11 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -27,6 +27,10 @@ AM_CFLAGS =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(OPTIONAL_CRYPTO_CFLAGS) \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(OPTIONAL_LZO_CFLAGS) \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(OPTIONAL_PKCS11_HELPER_CFLAGS)
> +if WIN32
> +# we want unicode entry point but not the macro
> +AM_CFLAGS +=3D -municode -UUNICODE
> +endif
>
> =C2=A0sbin_PROGRAMS =3D openvpn
>
> @@ -118,5 +122,5 @@ openvpn_LDADD =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(OPTIONAL_DL_LIBS)
> =C2=A0if WIN32
> =C2=A0openvpn_SOURCES +=3D openvpn_win32_resources.rc
> -openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwin=
mm -lshell32
> +openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwin=
mm
> =C2=A0endif
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index 3db1b86..6e70a58 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -127,8 +127,9 @@ tunnel_point_to_point (struct context *c)
> =C2=A0* @param argc - Commandline argument count.
> =C2=A0* @param argv - Commandline argument values.
> =C2=A0*/
> +static
> =C2=A0int
> -main (int argc, char *argv[])
> +openvpn_main (int argc, char *argv[])
> =C2=A0{
> =C2=A0 struct context c;
>
> @@ -289,3 +290,37 @@ main (int argc, char *argv[])
> =C2=A0 openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); =C2=A0/* exit point */
> =C2=A0 return 0; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* NOTREACHED */
> =C2=A0}
> +
> +#ifdef WIN32
> +int
> +wmain (int argc, wchar_t *wargv[]) {
> + =C2=A0char **argv;
> + =C2=A0int ret;
> + =C2=A0int i;
> +
> + =C2=A0if ((argv =3D calloc(argc+1, sizeof(char*))) =3D=3D NULL)
> + =C2=A0 =C2=A0return 1;
> +
> + =C2=A0for (i =3D 0; i < argc; i++)
> + =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0int n =3D WideCharToMultiByte (CP_UTF8, 0, wargv[i]=
, -1, NULL, 0, NULL, NULL);
> + =C2=A0 =C2=A0 =C2=A0argv[i] =3D malloc (n);
> + =C2=A0 =C2=A0 =C2=A0WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, argv=
[i], n, NULL, NULL);
> + =C2=A0 =C2=A0}
> +
> + =C2=A0ret =3D openvpn_main(argc, argv);
> +
> + =C2=A0for (i=3D0; i < argc; i++ )
> + =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0free (argv[i]);
> + =C2=A0 =C2=A0}
> + =C2=A0free(argv);
> +
> + =C2=A0return ret;
> +}
> +#else
> +int
> +main (int argc, char *argv[]) {
> + =C2=A0 =C2=A0 =C2=A0 return openvpn_main(argc, argv);
> +}
> +#endif
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> old mode 100644
> new mode 100755
> index 51e19af..452876f
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -18,12 +18,12 @@
> =C2=A0 <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
> =C2=A0 <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'" Label=3D"Configuration">
> =C2=A0 =C2=A0 <ConfigurationType>Application</ConfigurationType>
> - =C2=A0 =C2=A0<CharacterSet>MultiByte</CharacterSet>
> =C2=A0 =C2=A0 <WholeProgramOptimization>true</WholeProgramOptimization>
> + =C2=A0 =C2=A0<CharacterSet>Unicode</CharacterSet>
> =C2=A0 </PropertyGroup>
> =C2=A0 <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|Win32'" Label=3D"Configuration">
> =C2=A0 =C2=A0 <ConfigurationType>Application</ConfigurationType>
> - =C2=A0 =C2=A0<CharacterSet>MultiByte</CharacterSet>
> + =C2=A0 =C2=A0<CharacterSet>Unicode</CharacterSet>
> =C2=A0 </PropertyGroup>
> =C2=A0 <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> =C2=A0 <ImportGroup Label=3D"ExtensionSettings">
> @@ -56,12 +56,13 @@
> =C2=A0 =C2=A0 =C2=A0 </PrecompiledHeader>
> =C2=A0 =C2=A0 =C2=A0 <WarningLevel>Level3</WarningLevel>
> =C2=A0 =C2=A0 =C2=A0 <DebugInformationFormat>EditAndContinue</DebugInform=
ationFormat>
> + =C2=A0 =C2=A0 =C2=A0<UndefinePreprocessorDefinitions>UNICODE</UndefineP=
reprocessorDefinitions>
> =C2=A0 =C2=A0 </ClCompile>
> =C2=A0 =C2=A0 <ResourceCompile>
> =C2=A0 =C2=A0 =C2=A0 <AdditionalIncludeDirectories>$(SOURCEBASE);%(Additi=
onalIncludeDirectories)</AdditionalIncludeDirectories>
> =C2=A0 =C2=A0 </ResourceCompile>
> =C2=A0 =C2=A0 <Link>
> - =C2=A0 =C2=A0 =C2=A0<AdditionalDependencies>libeay32.lib;ssleay32.lib;l=
zo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;=
iphlpapi.lib;winmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDep=
endencies>
> + =C2=A0 =C2=A0 =C2=A0<AdditionalDependencies>libeay32.lib;ssleay32.lib;l=
zo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;=
iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
> =C2=A0 =C2=A0 =C2=A0 <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(=
LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</Addition=
alLibraryDirectories>
> =C2=A0 =C2=A0 =C2=A0 <GenerateDebugInformation>true</GenerateDebugInforma=
tion>
> =C2=A0 =C2=A0 =C2=A0 <SubSystem>Console</SubSystem>
> @@ -80,12 +81,13 @@
> =C2=A0 =C2=A0 =C2=A0 </PrecompiledHeader>
> =C2=A0 =C2=A0 =C2=A0 <WarningLevel>Level3</WarningLevel>
> =C2=A0 =C2=A0 =C2=A0 <DebugInformationFormat>ProgramDatabase</DebugInform=
ationFormat>
> + =C2=A0 =C2=A0 =C2=A0<UndefinePreprocessorDefinitions>UNICODE</UndefineP=
reprocessorDefinitions>
> =C2=A0 =C2=A0 </ClCompile>
> =C2=A0 =C2=A0 <ResourceCompile>
> =C2=A0 =C2=A0 =C2=A0 <AdditionalIncludeDirectories>$(SOURCEBASE);%(Additi=
onalIncludeDirectories)</AdditionalIncludeDirectories>
> =C2=A0 =C2=A0 </ResourceCompile>
> =C2=A0 =C2=A0 <Link>
> - =C2=A0 =C2=A0 =C2=A0<AdditionalDependencies>libeay32.lib;ssleay32.lib;l=
zo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;=
iphlpapi.lib;winmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDep=
endencies>
> + =C2=A0 =C2=A0 =C2=A0<AdditionalDependencies>libeay32.lib;ssleay32.lib;l=
zo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;=
iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
> =C2=A0 =C2=A0 =C2=A0 <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(=
LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</Addition=
alLibraryDirectories>
> =C2=A0 =C2=A0 =C2=A0 <GenerateDebugInformation>true</GenerateDebugInforma=
tion>
> =C2=A0 =C2=A0 =C2=A0 <SubSystem>Console</SubSystem>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 25786f6..66241b4 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3832,33 +3832,6 @@ parse_argv (struct options *options,
> =C2=A0{
> =C2=A0 int i, j;
>
> -#ifdef WIN32
> - =C2=A0/*
> - =C2=A0 * Windows replaces Unicode characters in argv[] that are not pre=
sent
> - =C2=A0 * in the current codepage with '?'. Get the wide char command li=
ne and
> - =C2=A0 * convert it to UTF-8 ourselves.
> - =C2=A0 */
> - =C2=A0int wargc;
> - =C2=A0WCHAR **wargv;
> - =C2=A0char **uargv;
> -
> - =C2=A0wargv =3D CommandLineToArgvW (GetCommandLineW (), &wargc);
> - =C2=A0if (wargv =3D=3D NULL || wargc !=3D argc)
> - =C2=A0 =C2=A0usage ();
> -
> - =C2=A0uargv =3D gc_malloc (wargc * sizeof (*uargv), false, &options->gc=
);
> -
> - =C2=A0for (i =3D 0; i < wargc; i++)
> - =C2=A0 =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0int n =3D WideCharToMultiByte (CP_UTF8, 0, wargv[i]=
, -1, NULL, 0, NULL, NULL);
> - =C2=A0 =C2=A0 =C2=A0uargv[i] =3D gc_malloc (n, false, &options->gc);
> - =C2=A0 =C2=A0 =C2=A0WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, uarg=
v[i], n, NULL, NULL);
> - =C2=A0 =C2=A0}
> -
> - =C2=A0LocalFree (wargv);
> - =C2=A0argv =3D uargv;
> -#endif
> -
> =C2=A0 /* usage message */
> =C2=A0 if (argc <=3D 1)
> =C2=A0 =C2=A0 usage ();
> --
> 1.7.3.4
>

