Date: Thu, 24 Aug 2017 21:18:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170824191848.GH70062@...1296...>
References: <20170824133305.25604-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mpBQsTDkJwM+mRv6"
Content-Disposition: inline
In-Reply-To: <20170824133305.25604-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--mpBQsTDkJwM+mRv6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 24, 2017 at 09:33:05PM +0800, Antonio Quartulli wrote:
> The backquotes for command substitution in bash are
> considered old-style in favour of the more modern $() [1].
> Substitute them.
>=20
> [1]https://www.gnu.org/software/bash/manual/html_node/Command-Substitutio=
n.html#Command-Substitution

We do, pointedly, *not* care about *bash* compatibility, but about
"it works on all the oddball shells you happen to find on any of the
supported platforms".

So, NAK, unless you have tested with ksh, and the system /bin/sh on at=20
least Solaris and AIX.

Please do not change working shell script stuff just because *bash* says
"this is the more modern way!".

(gen-release-tarballs.sh only needs to work on FreeBSD and Linux, and
FreeBSD's /bin/sh is sufficiently modern so so it's likely to work
 - but the test scripts need to run robustly everywhere a user builds,
so never assume "because bash says so!" is a way anywhere but into worlds
of pain.  And yes, we've been there before :-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mpBQsTDkJwM+mRv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZnyaXAAoJEB2Cnv7KVigSMiIL/2ZcxeCOn2xC3FVrFwGKF8DF
qs5/MUN9PUNUTUiUm7eEg6DNO6VDS8yxmRKTsV2FMhaxIHsYNjIqgWS3YVfTEGX1
uXqpqC0Q5RB7kLJqfSgm+jUuP2SyuHmcOjdn8LtjMD56d71ZmPrBMuNYDi+90Z3w
CTT4RWbYpiZp/XyXeH4Muv++bXH+TaopiFdM7+S45RTG7cmwfIvgk6ExSthYaut4
o9aSL4FoLrZKAk0IIWqkYG9LFgi/kKzINR40cC2NyAq3GLlS4LmZIQ3t5GyOIhqj
uugKX5tN+V5nlnwvmmX56wbQyJxOEOGCmODSjWokz1OHNQqxK52A0l3DO1gSImXr
biwBkooTiSeb99b+h3ZbvQuerkjEFnFJ+eOgyMTFndYJDD/IeNBvfzYwmzq5e5kw
Mn9zsgc0buTpFsOhyPlFSmUEAfcO+VB9ixfB4xGuE8XHYqlxLU2IMMDSZdubZdNS
1kwrV5/AB+FUYb6XBXhPMVJICjJHaCp0FPR6j7KGaA==
=ns4B
-----END PGP SIGNATURE-----

--mpBQsTDkJwM+mRv6--

