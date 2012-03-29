MIME-Version: 1.0
In-Reply-To: <4F743D70.1090704@...1114...>
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
	<4F743D70.1090704@...1114...>
Date: Thu, 29 Mar 2012 14:51:20 +0200
Message-ID: <CAOazyz03pDXURcMLY_RgvEQcXHn-ftj0HHi-nG3H81tX2JadnA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] build: msvc: upgrade to Visual
 Studio 2010 + fixups
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

This is not good.
Another issue of this MIME magic that should be avoided.
VC files are CRLF, if we do not commit them this way, every time they
change we see a complete rewrite.

If you do not want to pull, please do:

find . -name '*.sln' -or -name '*.vcxproj.*' | xargs unix2dos

And commit.

On Thu, Mar 29, 2012 at 12:46 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 24/03/12 08:58, Alon Bar-Lev wrote:
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- .gitignore
>> | =C2=A0 =C2=A02 + build/msvc/msvc-generate/Makefile.am =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> build/msvc/msvc-generate/msvc-generate.vcproj =C2=A0| =C2=A0 74 ---
>> build/msvc/msvc-generate/msvc-generate.vcxproj | =C2=A0 69 +++
>> msvc-build.bat =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 27 +- msvc=
-dev.bat
>> | =C2=A0 19 +- msvc-env.bat =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A07 +-
>> openvpn.sln =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
90 ++--
>> src/compat/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +-
>> src/compat/compat.vcproj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0197 ------
>> src/compat/compat.vcxproj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 87 +++
>> src/compat/compat.vcxproj.filters =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 42 ++
>> src/openvpn/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A03 +-
>> src/openvpn/openvpn.vcproj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0777
>> ------------------------ src/openvpn/openvpn.vcxproj
>> | =C2=A0261 ++++++++ src/openvpn/openvpn.vcxproj.filters =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0458
>> ++++++++++++++ src/openvpnserv/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A03
>> +- src/openvpnserv/openvpnserv.vcproj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0209 -------
>> src/openvpnserv/openvpnserv.vcxproj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0112 ++++
>> src/openvpnserv/openvpnserv.vcxproj.filters =C2=A0 =C2=A0| =C2=A0 35 ++ =
20 files
>> changed, 1153 insertions(+), 1324 deletions(-) delete mode 100644
>> build/msvc/msvc-generate/msvc-generate.vcproj create mode 100644
>> build/msvc/msvc-generate/msvc-generate.vcxproj delete mode 100644
>> src/compat/compat.vcproj create mode 100644 src/compat/compat.vcxproj
>> create mode 100644 src/compat/compat.vcxproj.filters delete mode
>> 100644 src/openvpn/openvpn.vcproj create mode 100644
>> src/openvpn/openvpn.vcxproj create mode 100644
>> src/openvpn/openvpn.vcxproj.filters delete mode 100644
>> src/openvpnserv/openvpnserv.vcproj create mode 100644
>> src/openvpnserv/openvpnserv.vcxproj create mode 100644
>> src/openvpnserv/openvpnserv.vcxproj.filters
>
> Applied to master branches on -testing and -stable trees.
>
>
> commit 3c1971de878bb3658c38b0504f314d38b6b765d2
> Author: Alon Bar-Lev <alon.barlev@...277...>
> Date: =C2=A0 Sat Mar 24 09:58:36 2012 +0200
>
> =C2=A0 =C2=A0Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> =C2=A0 =C2=A0Acked-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> =C2=A0 =C2=A0Signed-off-by: David Sommerseth <davids@...1347...>
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk90PW0ACgkQDC186MBRfroUVwCeLLO68J69XstVm9+0pm+I0PVc
> zysAnAgYqMa+Jp6UFQGa1H+vGQj98pxQ
> =3DZYPY
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------=
-----
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

