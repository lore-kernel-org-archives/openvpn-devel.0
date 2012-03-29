Message-ID: <4F745CE6.5070608@...1114...>
Date: Thu, 29 Mar 2012 15:00:22 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
	<4F743D70.1090704@...1114...>
	<CAOazyz03pDXURcMLY_RgvEQcXHn-ftj0HHi-nG3H81tX2JadnA@...278...>
In-Reply-To: <CAOazyz03pDXURcMLY_RgvEQcXHn-ftj0HHi-nG3H81tX2JadnA@...278...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29/03/12 14:51, Alon Bar-Lev wrote:
> This is not good. Another issue of this MIME magic that should be
> avoided. VC files are CRLF, if we do not commit them this way,
> every time they change we see a complete rewrite.
>=20
> If you do not want to pull, please do:
>=20
> find . -name '*.sln' -or -name '*.vcxproj.*' | xargs unix2dos
>=20
> And commit.

We had quite some clean-up rounds on CR/LF issues quite a while ago.
After a lot of testing and searching the net, we found out that
keeping the git tree NL only would be an advantage.  And CR/LF issues
would be avoided when setting 'git config --global core.autocrlf true'
on Windows boxes.  This makes git add CR/LF when checking out files
from the repo automatically, and it will be stripped out when
committing files.

It's also described here:
<https://community.openvpn.net/openvpn/wiki/GitCrashCourse#Otherneatfeature=
stoenable>

Can you please double check if this works for you?  Then we don't have
to bother with the CR/LF issues at all, as it's mostly automatic.


kind regards,

David Sommerseth



> On Thu, Mar 29, 2012 at 12:46 PM, David Sommerseth=20
> <openvpn.list@...1114...> wrote: On 24/03/12 08:58, Alon
> Bar-Lev wrote:
>>>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> ---
>>>> .gitignore |    2 + build/msvc/msvc-generate/Makefile.am
>>>> |    2 +- build/msvc/msvc-generate/msvc-generate.vcproj  |
>>>> 74 --- build/msvc/msvc-generate/msvc-generate.vcxproj |   69
>>>> +++ msvc-build.bat                                 |   27 +-
>>>> msvc-dev.bat |   19 +- msvc-env.bat
>>>> |    7 +- openvpn.sln                                    |
>>>> 90 ++-- src/compat/Makefile.am                         |    3
>>>> +- src/compat/compat.vcproj                       |  197
>>>> ------ src/compat/compat.vcxproj                      |   87
>>>> +++ src/compat/compat.vcxproj.filters              |   42 ++=20
>>>> src/openvpn/Makefile.am                        |    3 +-=20
>>>> src/openvpn/openvpn.vcproj                     |  777=20
>>>> ------------------------ src/openvpn/openvpn.vcxproj |  261
>>>> ++++++++ src/openvpn/openvpn.vcxproj.filters            |
>>>> 458 ++++++++++++++ src/openvpnserv/Makefile.am
>>>> |    3 +- src/openvpnserv/openvpnserv.vcproj             |
>>>> 209 ------- src/openvpnserv/openvpnserv.vcxproj            |
>>>> 112 ++++ src/openvpnserv/openvpnserv.vcxproj.filters    |
>>>> 35 ++ 20 files changed, 1153 insertions(+), 1324 deletions(-)
>>>> delete mode 100644=20
>>>> build/msvc/msvc-generate/msvc-generate.vcproj create mode
>>>> 100644 build/msvc/msvc-generate/msvc-generate.vcxproj delete
>>>> mode 100644 src/compat/compat.vcproj create mode 100644
>>>> src/compat/compat.vcxproj create mode 100644
>>>> src/compat/compat.vcxproj.filters delete mode 100644
>>>> src/openvpn/openvpn.vcproj create mode 100644=20
>>>> src/openvpn/openvpn.vcxproj create mode 100644=20
>>>> src/openvpn/openvpn.vcxproj.filters delete mode 100644=20
>>>> src/openvpnserv/openvpnserv.vcproj create mode 100644=20
>>>> src/openvpnserv/openvpnserv.vcxproj create mode 100644=20
>>>> src/openvpnserv/openvpnserv.vcxproj.filters
>=20
> Applied to master branches on -testing and -stable trees.
>=20
>=20
> commit 3c1971de878bb3658c38b0504f314d38b6b765d2 Author: Alon
> Bar-Lev <alon.barlev@...277...> Date:   Sat Mar 24 09:58:36 2012
> +0200
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> Acked-by:
> Samuli Sepp=C3=A4nen <samuli@...515...> Signed-off-by: David
> Sommerseth <davids@...1347...>
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>>=20
>> ------------------------------------------------------------------------=
------
>>
>>=20
This SF email is sponsosred by:
>> Try Windows Azure free for 90 days Click Here=20
>> http://p.sf.net/sfu/sfd2d-msazure=20
>> _______________________________________________ Openvpn-devel
>> mailing list Openvpn-devel@lists.sourceforge.net=20
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk90XOQACgkQDC186MBRfrriugCaA58VFgV1k15ebL/h0Uk4FExx
u4MAnRL5oNuoLPym6qH3Jc/Rzf28ZcJP
=3DO/kG
-----END PGP SIGNATURE-----

