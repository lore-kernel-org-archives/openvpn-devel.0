MIME-Version: 1.0
In-Reply-To: <4F9A7F67.2000602@...515...>
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
	<1332621070-28464-1-git-send-email-alon.barlev@...277...>
	<4F9A5EB7.902@...515...>
	<CAOazyz1V2ayJH28+aGh=C46vuxHkDmZA-x_CPn1hhqwsLMYngA@...278...>
	<4F9A7F67.2000602@...515...>
Date: Fri, 27 Apr 2012 14:24:58 +0300
Message-ID: <CAOazyz2gj6ecoKKvfmiQBtEGwxyDmLOb1Vpd25JrSVSspaWWtw@...278...>
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

Here is a simple program that will make it easier for you....

The file in ca and pkcs12 parameters is found when using Hebrew.

Alon.

---
#include <Windows.h>

int main(void) {
	WCHAR cmdline[] =3D
L"s:\\Temp\\openvpn\\build-win32\\src\\openvpn\\.libs\\openvpn.exe
--dev tap --tls-client --ca c:\\temp\\=D7=A2=D7=91=D7=A8=D7=99=D7=AA\\=D7=
=A0=D7=99=D7=A1=D7=95=D7=99.txt --pkcs12
c:\\temp\\=D7=A2=D7=91=D7=A8=D7=99=D7=AA\\=D7=A0=D7=99=D7=A1=D7=95=D7=99.tx=
t";
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	ZeroMemory(&si, sizeof(si));
	si.cb =3D sizeof(si);
	ZeroMemory(&pi, sizeof(pi));
	CreateProcessW(
		NULL,
		cmdline,
		NULL,
		NULL,
		TRUE,
		0,
		NULL,
		NULL,
		&si,
		&pi
	);
	return 0;
}
---

2012/4/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>
>> Hello Samuli,
>>
>> Curios: Did you manage to get it work using master without my patch?
>
> Nope, although I only tested it briefly. I'll try that again just in case.
>
>> If not, to make it easy...
>>
>> Use Windows Explorer and rename the key file to something non-ascii.
>> Then open openvpn configuration using UTF-8 editor and modify key file t=
here.
>> This should work, as we do not use unicode/conversion command-line.
>>
>> Next step would be to remove the key from configuration and use it in
>> command-line.
>>
>> Alon.
>
> Thanks, I'll try that.
>
> Samuli
>
>>
>> 2012/4/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>> Hi,
>>>
>>> As promised in yesterday's IRC meeting (summary coming today), I tested
>>> this patch on Windows 7 (64-bit). So far I've had no luck, but don't
>>> think the problems have anything to do with this patch.
>>>
>>> Anyways, I cross-compiled latest "master" with this patch applied and
>>> "bin" and "lib" directories on top of an existing openvpn-2.3-alpha1
>>> install. The old "bin" directory was renamed to make sure none of it was
>>> used. I then renamed "openvpn.ovpn" to "=C3=A4=C3=A4li=C3=B6.ovpn" and =
"ta.key" to
>>> "=C3=A4=C3=A4li=C3=B6.key" using Windows Explorer. Then I updated the c=
onfiguration
>>> file to point to these files using Notepad (and later Wordpad).
>>>
>>> OpenVPN-GUI (Heiko's new version) detected the configuration file
>>> properly, showing "=C3=A4=C3=A4li=C3=B6" as one available connection op=
tion. However,
>>> it output the following when trying to connect:
>>>
>>> =C2=A0 =C2=A0Options error: --tls-auth fails with '=C3=A4=C3=A4li=C3=B6=
.key': No such file or
>>> directory
>>>
>>> Git Bash showed the file as ??li?.key, which could mean Windows Explorer
>>> is using a single-byte character set.
>>>
>>> Windows command prompt shows the characters properly, but issuing
>>> "openvpn --config =C3=A4=C3=A4li=C3=B6.ovpn" gives the same error as Op=
enVPN-GUI above,
>>> except that '=C3=A4=C3=A4li=C3=B6.key' shows faulty glyphs[1]. This als=
o triggers an
>>> interesting bug in the command prompt[2]
>>>
>>> Anyways, as the Windows 7 install is English-language, I suspect it's
>>> using a single-byte character set instead of UCS-2. I'll continue
>>> debugging, but any pointers are obviously much appreciated!
>>>
>>> Samuli
>>>
>>> [1] <http://users.utu.fi/sjsepp/cmd.png>
>>> [2] Typing an "=C3=A4" or "=C3=B6" moves the (invisible) cursor forward=
 one
>>> character, but each backspace will delete two characters instead of one.
>>> This does not happen until openvpn has been (unsuccessfully) started.
>>>
>>>
>>>> Discussed at [1].
>>>>
>>>> Use wmain under windows, drop the custom parsing and shell32 linkage.
>>>>
>>>> There is no need for gc magic as this allocation is static.
>>>>
>>>> [1] http://permalink.gmane.org/gmane.network.openvpn.devel/5433
>>>>
>>>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>>>> ---
>>>> =C2=A0src/openvpn/Makefile.am =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +++++-
>>>> =C2=A0src/openvpn/openvpn.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 37 +++++++++=
+++++++++++++++++++++++++++-
>>>> =C2=A0src/openvpn/openvpn.vcxproj | =C2=A0 10 ++++++----
>>>> =C2=A0src/openvpn/options.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 27 ---------=
------------------
>>>> =C2=A04 files changed, 47 insertions(+), 33 deletions(-)
>>>> =C2=A0mode change 100644 =3D> 100755 src/openvpn/openvpn.vcxproj
>>>>
>>>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>>>> index 4e485e7..0506b11 100644
>>>> --- a/src/openvpn/Makefile.am
>>>> +++ b/src/openvpn/Makefile.am
>>>> @@ -27,6 +27,10 @@ AM_CFLAGS =3D \
>>>> =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_CFLAGS) \
>>>> =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_LZO_CFLAGS) \
>>>> =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_PKCS11_HELPER_CFLAGS)
>>>> +if WIN32
>>>> +# we want unicode entry point but not the macro
>>>> +AM_CFLAGS +=3D -municode -UUNICODE
>>>> +endif
>>>>
>>>> =C2=A0sbin_PROGRAMS =3D openvpn
>>>>
>>>> @@ -118,5 +122,5 @@ openvpn_LDADD =3D \
>>>> =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_DL_LIBS)
>>>> =C2=A0if WIN32
>>>> =C2=A0openvpn_SOURCES +=3D openvpn_win32_resources.rc
>>>> -openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -l=
winmm -lshell32
>>>> +openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -l=
winmm
>>>> =C2=A0endif
>>>> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
>>>> index 3db1b86..6e70a58 100644
>>>> --- a/src/openvpn/openvpn.c
>>>> +++ b/src/openvpn/openvpn.c
>>>> @@ -127,8 +127,9 @@ tunnel_point_to_point (struct context *c)
>>>> =C2=A0 * @param argc - Commandline argument count.
>>>> =C2=A0 * @param argv - Commandline argument values.
>>>> =C2=A0 */
>>>> +static
>>>> =C2=A0int
>>>> -main (int argc, char *argv[])
>>>> +openvpn_main (int argc, char *argv[])
>>>> =C2=A0{
>>>> =C2=A0 =C2=A0struct context c;
>>>>
>>>> @@ -289,3 +290,37 @@ main (int argc, char *argv[])
>>>> =C2=A0 =C2=A0openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); =C2=A0/* exit po=
int */
>>>> =C2=A0 =C2=A0return 0; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* NOTREACHED */
>>>> =C2=A0}
>>>> +
>>>> +#ifdef WIN32
>>>> +int
>>>> +wmain (int argc, wchar_t *wargv[]) {
>>>> + =C2=A0char **argv;
>>>> + =C2=A0int ret;
>>>> + =C2=A0int i;
>>>> +
>>>> + =C2=A0if ((argv =3D calloc(argc+1, sizeof(char*))) =3D=3D NULL)
>>>> + =C2=A0 =C2=A0return 1;
>>>> +
>>>> + =C2=A0for (i =3D 0; i < argc; i++)
>>>> + =C2=A0 =C2=A0{
>>>> + =C2=A0 =C2=A0 =C2=A0int n =3D WideCharToMultiByte (CP_UTF8, 0, wargv=
[i], -1, NULL, 0, NULL, NULL);
>>>> + =C2=A0 =C2=A0 =C2=A0argv[i] =3D malloc (n);
>>>> + =C2=A0 =C2=A0 =C2=A0WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, a=
rgv[i], n, NULL, NULL);
>>>> + =C2=A0 =C2=A0}
>>>> +
>>>> + =C2=A0ret =3D openvpn_main(argc, argv);
>>>> +
>>>> + =C2=A0for (i=3D0; i < argc; i++ )
>>>> + =C2=A0 =C2=A0{
>>>> + =C2=A0 =C2=A0 =C2=A0free (argv[i]);
>>>> + =C2=A0 =C2=A0}
>>>> + =C2=A0free(argv);
>>>> +
>>>> + =C2=A0return ret;
>>>> +}
>>>> +#else
>>>> +int
>>>> +main (int argc, char *argv[]) {
>>>> + =C2=A0 =C2=A0 return openvpn_main(argc, argv);
>>>> +}
>>>> +#endif
>>>> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
>>>> old mode 100644
>>>> new mode 100755
>>>> index 51e19af..452876f
>>>> --- a/src/openvpn/openvpn.vcxproj
>>>> +++ b/src/openvpn/openvpn.vcxproj
>>>> @@ -18,12 +18,12 @@
>>>> =C2=A0 =C2=A0<Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default=
.props" />
>>>> =C2=A0 =C2=A0<PropertyGroup Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Release|Win32'" Label=3D"Configuration">
>>>> =C2=A0 =C2=A0 =C2=A0<ConfigurationType>Application</ConfigurationType>
>>>> - =C2=A0 =C2=A0<CharacterSet>MultiByte</CharacterSet>
>>>> =C2=A0 =C2=A0 =C2=A0<WholeProgramOptimization>true</WholeProgramOptimi=
zation>
>>>> + =C2=A0 =C2=A0<CharacterSet>Unicode</CharacterSet>
>>>> =C2=A0 =C2=A0</PropertyGroup>
>>>> =C2=A0 =C2=A0<PropertyGroup Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Debug|Win32'" Label=3D"Configuration">
>>>> =C2=A0 =C2=A0 =C2=A0<ConfigurationType>Application</ConfigurationType>
>>>> - =C2=A0 =C2=A0<CharacterSet>MultiByte</CharacterSet>
>>>> + =C2=A0 =C2=A0<CharacterSet>Unicode</CharacterSet>
>>>> =C2=A0 =C2=A0</PropertyGroup>
>>>> =C2=A0 =C2=A0<Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" =
/>
>>>> =C2=A0 =C2=A0<ImportGroup Label=3D"ExtensionSettings">
>>>> @@ -56,12 +56,13 @@
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0</PrecompiledHeader>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<WarningLevel>Level3</WarningLevel>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<DebugInformationFormat>EditAndContinue</De=
bugInformationFormat>
>>>> + =C2=A0 =C2=A0 =C2=A0<UndefinePreprocessorDefinitions>UNICODE</Undefi=
nePreprocessorDefinitions>
>>>> =C2=A0 =C2=A0 =C2=A0</ClCompile>
>>>> =C2=A0 =C2=A0 =C2=A0<ResourceCompile>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<AdditionalIncludeDirectories>$(SOURCEBASE)=
;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
>>>> =C2=A0 =C2=A0 =C2=A0</ResourceCompile>
>>>> =C2=A0 =C2=A0 =C2=A0<Link>
>>>> - =C2=A0 =C2=A0 =C2=A0<AdditionalDependencies>libeay32.lib;ssleay32.li=
b;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.l=
ib;iphlpapi.lib;winmm.lib;shell32.lib;%(AdditionalDependencies)</Additional=
Dependencies>
>>>> + =C2=A0 =C2=A0 =C2=A0<AdditionalDependencies>libeay32.lib;ssleay32.li=
b;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.l=
ib;iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<AdditionalLibraryDirectories>$(OPENSSL_HOM=
E)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)<=
/AdditionalLibraryDirectories>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<GenerateDebugInformation>true</GenerateDeb=
ugInformation>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<SubSystem>Console</SubSystem>
>>>> @@ -80,12 +81,13 @@
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0</PrecompiledHeader>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<WarningLevel>Level3</WarningLevel>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<DebugInformationFormat>ProgramDatabase</De=
bugInformationFormat>
>>>> + =C2=A0 =C2=A0 =C2=A0<UndefinePreprocessorDefinitions>UNICODE</Undefi=
nePreprocessorDefinitions>
>>>> =C2=A0 =C2=A0 =C2=A0</ClCompile>
>>>> =C2=A0 =C2=A0 =C2=A0<ResourceCompile>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<AdditionalIncludeDirectories>$(SOURCEBASE)=
;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
>>>> =C2=A0 =C2=A0 =C2=A0</ResourceCompile>
>>>> =C2=A0 =C2=A0 =C2=A0<Link>
>>>> - =C2=A0 =C2=A0 =C2=A0<AdditionalDependencies>libeay32.lib;ssleay32.li=
b;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.l=
ib;iphlpapi.lib;winmm.lib;shell32.lib;%(AdditionalDependencies)</Additional=
Dependencies>
>>>> + =C2=A0 =C2=A0 =C2=A0<AdditionalDependencies>libeay32.lib;ssleay32.li=
b;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.l=
ib;iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<AdditionalLibraryDirectories>$(OPENSSL_HOM=
E)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)<=
/AdditionalLibraryDirectories>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<GenerateDebugInformation>true</GenerateDeb=
ugInformation>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0<SubSystem>Console</SubSystem>
>>>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>>>> index 25786f6..66241b4 100644
>>>> --- a/src/openvpn/options.c
>>>> +++ b/src/openvpn/options.c
>>>> @@ -3832,33 +3832,6 @@ parse_argv (struct options *options,
>>>> =C2=A0{
>>>> =C2=A0 =C2=A0int i, j;
>>>>
>>>> -#ifdef WIN32
>>>> - =C2=A0/*
>>>> - =C2=A0 * Windows replaces Unicode characters in argv[] that are not =
present
>>>> - =C2=A0 * in the current codepage with '?'. Get the wide char command=
 line and
>>>> - =C2=A0 * convert it to UTF-8 ourselves.
>>>> - =C2=A0 */
>>>> - =C2=A0int wargc;
>>>> - =C2=A0WCHAR **wargv;
>>>> - =C2=A0char **uargv;
>>>> -
>>>> - =C2=A0wargv =3D CommandLineToArgvW (GetCommandLineW (), &wargc);
>>>> - =C2=A0if (wargv =3D=3D NULL || wargc !=3D argc)
>>>> - =C2=A0 =C2=A0usage ();
>>>> -
>>>> - =C2=A0uargv =3D gc_malloc (wargc * sizeof (*uargv), false, &options-=
>gc);
>>>> -
>>>> - =C2=A0for (i =3D 0; i < wargc; i++)
>>>> - =C2=A0 =C2=A0{
>>>> - =C2=A0 =C2=A0 =C2=A0int n =3D WideCharToMultiByte (CP_UTF8, 0, wargv=
[i], -1, NULL, 0, NULL, NULL);
>>>> - =C2=A0 =C2=A0 =C2=A0uargv[i] =3D gc_malloc (n, false, &options->gc);
>>>> - =C2=A0 =C2=A0 =C2=A0WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, u=
argv[i], n, NULL, NULL);
>>>> - =C2=A0 =C2=A0}
>>>> -
>>>> - =C2=A0LocalFree (wargv);
>>>> - =C2=A0argv =3D uargv;
>>>> -#endif
>>>> -
>>>> =C2=A0 =C2=A0/* usage message */
>>>> =C2=A0 =C2=A0if (argc <=3D 1)
>>>> =C2=A0 =C2=A0 =C2=A0usage ();
>
>

