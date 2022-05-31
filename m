Date: Tue, 31 May 2022 13:55:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YpYCFzR7BRbD9clN@...1296...>
References: <20220530154915.47349-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Dz85hJanRWOEDE6C"
Content-Disposition: inline
In-Reply-To: <20220530154915.47349-1-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH v3] Don't "undo" ifconfig on exit if it
 wasn't done
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--Dz85hJanRWOEDE6C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 30, 2022 at 05:49:15PM +0200, Max Fillinger wrote:
> When running with --ifconfig-noexec, OpenVPN does not execute ifconfig,
> but on exit, it still tries to "undo" the configuration it would have
> done. This patch fixes it by extracting an undo_ifconfig() function from
> close_tun(). The undo function is called before close_tun(), but only if
> --ifconfig-noexec isn't set. This is symmetric to how open_tun() and
> do_ifconfig() are used.
>=20
> This change also allows us to drop the second argument from close_tun().
>=20
> v2: Fix tabs-vs-spaces.
> v3: Fix another style mistake.

I like this approach much more than what we discussed previously.

Though, alas...

ld: error: undefined symbol: undo_ifconfig
>>> referenced by init.c:1863
>>>               init.o:(do_close_tun)
>>> referenced by init.c:1863
>>>               init.o:(do_close_tun)
cc: error: linker command failed with exit code 1 (use -v to see invocation)

... the current undo_ifconfig_*() functions are inside a TARGET_LINUX
block, so this change breaks all other platforms...

(Tried on FreeBSD, but my reading of the code suggest that all others
will fail too)

We could add undo_ifconfig_*() functions - or "do nothing" stubs - for
other platforms...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Dz85hJanRWOEDE6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJilgIXAAoJEB2Cnv7KVigS9voL+gOIHea6T1a8maRKF8F7D7ii
a0iMXKmi7pZNfkfwsElitWHaLY/neYuDmDQWTuEtOdn1Kz2Cr/JJ4d/LMxkg8L6H
KBfp2i+E0GsfJGdwXD3RXV203SHgDwh0cL74kbaWwJJ4lKkLbsyDcpyFzxZBYN4W
hW8hJZmX6rJyrd2VsDvxNo2Os8wzrAkz/HrmwUYwEOBqzLfBeslCuBEMoiutmsNL
qjZcZDdMjQ//LxAuxzTInOA7jp4X12taVvEDqYv2QH2lMurbEnblzgK5BWYdmzW9
dGsNwUNmdpk+zN0SeNZqV8lNHmIcyhJyfx5TaVqtIK2rYANJ6JEofyWYIl97s5SP
wNTMbE4mYKvNRFVT5Q7yImyGYdOAF8KtD9UaVayRV9NggvKH08Ce6FLWLlUJXS4g
EqyeGd6o04L3h4rgYSZQ3sjQjUg53krBZfH+t059cUWv6LW68ULdNcooXlmuGhY8
W8/GFRlUK0orqSKE+IoPA0nj/U8HddJHwgHKJ2NQbg==
=0wDN
-----END PGP SIGNATURE-----

--Dz85hJanRWOEDE6C--

