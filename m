References: <1474109679-4982-1-git-send-email-chipitsine@...277...>
	<CAA1AbxKesOCWi2gD6D9nOYVFB2ZyNzYnQsP-NNjWbzPGdG6SPg@...278...>
	<CAFHpkQHNbXW293tp3ua9fr5SwvuLgZh+nJKMR_yioUUVm0QUkg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <8a59c1b0-7bf5-47b8-68ed-ce36e4438c55@...515...>
Date: Mon, 26 Sep 2016 10:37:07 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHNbXW293tp3ua9fr5SwvuLgZh+nJKMR_yioUUVm0QUkg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] enable "--disable-crypto" build
 configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Il 24/09/2016 09:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
> can we merge it ?
>
> 2016-09-17 16:17 GMT+05:00 Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>>:
>
>     Hi,
>
>     On 17 September 2016 at 12:54, Ilya Shipitsin <chipitsine@...277...
>     <mailto:chipitsine@...277...>> wrote:
>     > ---
>     >  .travis.yml | 4 ----
>     >  1 file changed, 4 deletions(-)
>     >
>     > diff --git a/.travis.yml b/.travis.yml
>     > index 452c48e..369db97 100644
>     > --- a/.travis.yml
>     > +++ b/.travis.yml
>     > @@ -51,10 +51,6 @@ matrix:
>     >        os: osx
>     >        osx_image: xcode7.3
>     >        compiler: clang
>     > -  allow_failures:
>     > -    - env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--disable-crypto"
>     > -      os: linux
>     > -      compiler: clang
>     >    exclude:
>     >      - compiler: gcc
>     >
>     > --
>     > 2.5.5
>
>     Thanks.  The patch is good, so ACK.
>
>     But the commit messages should describe why this change is needed.  In
>     this case:
>
>     Previously, 'make test' failed for --disable-crypto builds.  Since
>     that is not fixed, we should no longer accept --disable-crypto builds
>     to fail 'make test' on travis.
>
>     Could you please include such descriptions in future patches?
>
>     -Steffan
>
>
>
>
> -------------------------------------------------------------------------=
-----
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

All the pieces (ACK, fixed commit message) seem to be present. Maybe it=20
would be easiest to fix the commit message just before the push:

---

Enable "--disable-crypto" build configuration

Previously, 'make test' failed for --disable-crypto builds.  Since
that is not fixed, we should no longer accept --disable-crypto builds
to fail 'make test' on travis.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

