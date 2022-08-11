Date: Thu, 11 Aug 2022 20:06:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvVFCe7Dfl8RfOkf@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
 <53752c1d-6d18-a50b-b3d1-a92fe43263cc@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vVaaP8vQYF2ugwRY"
Content-Disposition: inline
In-Reply-To: <53752c1d-6d18-a50b-b3d1-a92fe43263cc@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Kristof Provost <kprovost@...2661...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--vVaaP8vQYF2ugwRY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 11, 2022 at 07:00:25PM +0200, Arne Schwabe wrote:
> > I???ve pushed a fix for this panic in fd6b3bede5a5c210f327e5c9bd3e415ee=
905048b.
> > I simply didn???t think that user space might give us a non-UDP socket,=
 so checking for that and rejecting the peer in that case fixes the panic. =
Thanks for finding that.
>=20
> You should probably also modify the check for dco incompatible in=20
> OpenVPN so that using TCP disables DCO on FreeBSD.

Indeed.  One of the next patches will bring "per platform options check",
which would be a good place for the #ifdef TARGET_FREEBSD bits.

I'll see that I can pick part of that patch and apply it tomorrow
(the patch as posted refers to symbols that are brought in by the
"main" win-dco patch, but half of it should apply & make sense as is)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vVaaP8vQYF2ugwRY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi9UUJAAoJEB2Cnv7KVigSznML/jPQVdZ+BFrlsm0GP5cSidZz
o/0oLZUoxXIz8qZk0D0og1EVAZpXLLKCHKI18vzbEEE+CgJlydmChyPcbeMuiFJ5
Jih+WtTEkiz+Q08gXKzODmC5t8+nLYRWML1FfMfIfWap9KLyYd3tJSZ9atr7Z/tV
ICUeWi/D/b3nZSjUhIAgingTCnPcR5DXRG4x9jRNPnVhgVhj5oqBJoWGpbnQTmWr
qjocyBoTqdbpMCamQD7dG6TK8fC93W/s0L7EshYYuZZM0sFyWTPxJDnL4ekge+tN
tk+HdgkRncWTOVHw7tme9S1TmFmabtzBIT0FCen+5XNMixlfLkt0xoFFQEcElSp8
xQCfzJ4Nly1Cg5u//gh6pOiNJGbL/0oi2MMmO2OfLxLQxpJrC6lNNIIphfMYC31i
1EGXOUOaOi0oU0mgGQytJo66yTkiDpG5o0Zd1UDdfpvhfftEeq17pszDuogcTGID
vLYaEUpOnuABgzxVXLm6h7PD7anh+DjIeYynQRbP8g==
=jy2D
-----END PGP SIGNATURE-----

--vVaaP8vQYF2ugwRY--

