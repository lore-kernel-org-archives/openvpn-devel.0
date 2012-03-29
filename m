Message-ID: <4F743D70.1090704@...1114...>
Date: Thu, 29 Mar 2012 12:46:08 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332575918-3384-5-git-send-email-alon.barlev@...277...>
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/03/12 08:58, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- .gitignore
> |    2 + build/msvc/msvc-generate/Makefile.am           |    2 +-=20
> build/msvc/msvc-generate/msvc-generate.vcproj  |   74 ---=20
> build/msvc/msvc-generate/msvc-generate.vcxproj |   69 +++=20
> msvc-build.bat                                 |   27 +- msvc-dev.bat
> |   19 +- msvc-env.bat                                   |    7 +-=20
> openvpn.sln                                    |   90 ++--=20
> src/compat/Makefile.am                         |    3 +-=20
> src/compat/compat.vcproj                       |  197 ------=20
> src/compat/compat.vcxproj                      |   87 +++=20
> src/compat/compat.vcxproj.filters              |   42 ++=20
> src/openvpn/Makefile.am                        |    3 +-=20
> src/openvpn/openvpn.vcproj                     |  777
> ------------------------ src/openvpn/openvpn.vcxproj
> |  261 ++++++++ src/openvpn/openvpn.vcxproj.filters            |  458
> ++++++++++++++ src/openvpnserv/Makefile.am                    |    3
> +- src/openvpnserv/openvpnserv.vcproj             |  209 -------=20
> src/openvpnserv/openvpnserv.vcxproj            |  112 ++++=20
> src/openvpnserv/openvpnserv.vcxproj.filters    |   35 ++ 20 files
> changed, 1153 insertions(+), 1324 deletions(-) delete mode 100644
> build/msvc/msvc-generate/msvc-generate.vcproj create mode 100644
> build/msvc/msvc-generate/msvc-generate.vcxproj delete mode 100644
> src/compat/compat.vcproj create mode 100644 src/compat/compat.vcxproj=20
> create mode 100644 src/compat/compat.vcxproj.filters delete mode
> 100644 src/openvpn/openvpn.vcproj create mode 100644
> src/openvpn/openvpn.vcxproj create mode 100644
> src/openvpn/openvpn.vcxproj.filters delete mode 100644
> src/openvpnserv/openvpnserv.vcproj create mode 100644
> src/openvpnserv/openvpnserv.vcxproj create mode 100644
> src/openvpnserv/openvpnserv.vcxproj.filters

Applied to master branches on -testing and -stable trees.


commit 3c1971de878bb3658c38b0504f314d38b6b765d2
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sat Mar 24 09:58:36 2012 +0200

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=C3=A4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk90PW0ACgkQDC186MBRfroUVwCeLLO68J69XstVm9+0pm+I0PVc
zysAnAgYqMa+Jp6UFQGa1H+vGQj98pxQ
=3DZYPY
-----END PGP SIGNATURE-----

