MIME-Version: 1.0
In-Reply-To: <4F58B7C7.3030405@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-51-git-send-email-alon.barlev@...277...>
	<4F58B7C7.3030405@...515...>
Date: Thu, 8 Mar 2012 21:20:23 +0200
Message-ID: <CAOazyz094SD9t6J7U2yqX2cqXSg+WpHYsDNwvXgVP+FQfWgxmA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 50/52] build: windows: install
 version.sh to allow installer read version
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
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Not exactly.
It is used[1] by the packaging script... just sourced to get some
environment variables.

[1] https://github.com/alonbl/openvpn-build/blob/master/windows-nsis/build#=
L55

2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Is this meant to allow using these variables[1] in the NSIS script(s)?
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> [1]
>
> OPENVPN_PACKAGE_NAME=3D"@PACKAGE_NAME@"
> OPENVPN_PACKAGE_TARNAME=3D"@PACKAGE_TARNAME@"
> OPENVPN_PACKAGE_VERSION=3D"@PACKAGE_VERSION@"
> OPENVPN_PACKAGE_HOST=3D"@host@"
>
>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0.gitignore =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0Makefile.am =C2=A0 | =C2=A0 =C2=A05 +++++
>> =C2=A0configure.ac =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0version.sh.in | =C2=A0 =C2=A04 ++++
>> =C2=A04 files changed, 11 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 version.sh.in
>>
>> diff --git a/.gitignore b/.gitignore
>> index e7232cf..2f72ed8 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -39,6 +39,7 @@ m4/ltsugar.m4
>> =C2=A0m4/ltversion.m4
>> =C2=A0m4/lt~obsolete.m4
>>
>> +version.sh
>> =C2=A0msvc-env-local.bat
>> =C2=A0config-msvc-local.h
>> =C2=A0config-msvc-version.h
>> diff --git a/Makefile.am b/Makefile.am
>> index 5293518..68aa0a8 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -69,3 +69,8 @@ endif
>> =C2=A0dist_noinst_HEADERS =3D \
>> =C2=A0 =C2=A0 =C2=A0 config-msvc.h \
>> =C2=A0 =C2=A0 =C2=A0 config-msvc-version.h.in
>> +
>> +if WIN32
>> +rootdir=3D$(prefix)
>> +root_DATA =3D version.sh
>> +endif
>> diff --git a/configure.ac b/configure.ac
>> index d53a74a..0f2a62e 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -904,6 +904,7 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
>> =C2=A0AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>>
>> =C2=A0AC_CONFIG_FILES([
>> + =C2=A0 =C2=A0 version.sh
>> =C2=A0 =C2=A0 =C2=A0 Makefile
>> =C2=A0 =C2=A0 =C2=A0 build/Makefile
>> =C2=A0 =C2=A0 =C2=A0 build/msvc/Makefile
>> diff --git a/version.sh.in b/version.sh.in
>> new file mode 100644
>> index 0000000..2af5a36
>> --- /dev/null
>> +++ b/version.sh.in
>> @@ -0,0 +1,4 @@
>> +OPENVPN_PACKAGE_NAME=3D"@PACKAGE_NAME@"
>> +OPENVPN_PACKAGE_TARNAME=3D"@PACKAGE_TARNAME@"
>> +OPENVPN_PACKAGE_VERSION=3D"@PACKAGE_VERSION@"
>> +OPENVPN_PACKAGE_HOST=3D"@host@"
>
>

