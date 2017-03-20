Date: Mon, 20 Mar 2017 19:28:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170320182847.GJ93896@...1296...>
References: <e0ce41fa-d0b7-a5af-d021-133239911898@...277...>
	<20170319184135.23548-1-gert@...1296...>
	<6f73cd46-c9fc-10fa-2538-f820998c610e@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yyrU2RV5TDi8TCB2"
Content-Disposition: inline
In-Reply-To: <6f73cd46-c9fc-10fa-2538-f820998c610e@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Make ENABLE_OCC no longer depend on
 !ENABLE_SMALL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--yyrU2RV5TDi8TCB2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 20, 2017 at 07:20:50PM +0100, Steffan Karger wrote:
> > @@ -589,9 +589,7 @@ socket_defined(const socket_descriptor_t sd)
> >  /*
> >   * Should we include OCC (options consistency check) code?
> >   */
> > -#ifndef ENABLE_SMALL
> >  #define ENABLE_OCC
> > -#endif
> >=20=20
> >  /*
> >   * Should we include NTLM proxy functionality
> >=20
>=20
> If we unconditionally enable OCC, should we not just rip out #ifdef
> ENABLE_OCC everywhere?

We certainly could, but someone who still wants "no OCC! smaaall!"=20
still has the option to turn it off...

We might revisit that, though - there's "the option checking code",
which indeed brings in quite a bit of code that might be considered
optional, but there is also stuff in sig.c that makes --explicit-exit-notify
depend on ENABLE_OCC, and I'd consider that as something quite=20
important...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yyrU2RV5TDi8TCB2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY0B9fAAoJEB2Cnv7KVigSGZgL/2GEDD+SDJEpKbEsh+i1uiPf
IXLJJexNPCMypHXZhAYo4SQrnAJp2cEwBMONZ0+p+0aHW0G8ujIitilx/L8Ot+du
+BVExILoXTQHymA+wwg1o46TL8n6cPdxNWw4wEVZNcOFE69P55yvcUrfA8USv7Xx
5QoLTTWnFNvzJuk8ehlaJXpBugLqtJ136YkjIo4LIa7Wvqd3QDhpJIxlbxcwOHxE
8oAxE3tFBEXK1hC10hMJl49kJQLqII/OGKMueYeqkUjtD3VHaVs7iyLZ3nuwLt8c
1uXq3gDIapkV88a+avVk742h5vM2g/RYSsYZXEORVMNoFM/FUqkD/EsNgMJEnn79
SnrrdHnK5/2y4eLcb0jX2AHNiDlsg6FeFVqCYEnud/48tcm3Ay0cIp8zvJy394NS
hLTnS5jkvSvWFYfYMfAzZKsr3qum7MPJdOAcoVHi9rcoW0iq80mQVbA/uWmWIqj+
3Jx5B/ZllaJ05Li0VXmXPFFcGOnUabcUwmLSdDS8vw==
=5ErR
-----END PGP SIGNATURE-----

--yyrU2RV5TDi8TCB2--

