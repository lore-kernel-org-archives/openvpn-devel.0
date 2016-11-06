MIME-Version: 1.0
In-Reply-To: <CAFHpkQFqbsod+BrJ3VCt8UVjhwj8u=+SYG=0G2NVHWn9h9etpw@...278...>
References: <CAFHpkQFqbsod+BrJ3VCt8UVjhwj8u=+SYG=0G2NVHWn9h9etpw@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 6 Nov 2016 19:46:51 +0100
Message-ID: <CAA1AbxLUwoJpa=quJAUCAdNeo5p0gxuVi-vh0M36KvT60XAx4w@...278...>
Subject: Re: [Openvpn-devel] mingw cross build on travis-ci
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 6 November 2016 at 19:26, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> https://travis-ci.org/OpenVPN/openvpn/builds/173710684   :)
>
> everybody is welcome to comment (and make PR) here:
>
> https://github.com/OpenVPN/openvpn/pull/66
>
>
> why cross compile can be useful (even without "make check"):
>
> (*) it could catch 'c99 patch'
> (*) (after I add lzo, pkcs11) it will be the same as release build, so we
> can be sure, we didn't break the way windows installer is built

Cool, this is definitely useful.  I did some quick initial review on
github, but will have to look more into it later.

-Steffan

