Date: Tue, 4 Dec 2012 21:31:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121204203156.GH22465@...1296...>
References: <1354650174-25601-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TlGginnuNEm5PkhK"
Content-Disposition: inline
In-Reply-To: <1354650174-25601-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix the proto is used inconsistently
	warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--TlGginnuNEm5PkhK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 04, 2012 at 08:42:54PM +0100, Arne Schwabe wrote:
> Fix the "WARNING: 'proto' is used inconsistently, local=3D'proto UDP', re=
mote=3D'proto UDPv6'." message.
>=20
> Note that the on wire strings are now always TCPv4 and UDPv4 to be compat=
ible to pre2.3

The patch does what advertised, so I ACK it, and it should go into 2.3

OTOH, I want to put up the question whether sending "proto foo" in the
occ option string is of any use *at all* - because if the --proto setting
on both ends do not match, the connection won't even reach the point=20
where it could recognize the fact that "oh, it's because incompatible
--proto settings!".  So to achieve a null-feature, we have quite a bit
of code in "proto_remote()" in socket.c...


"Just throwing it out" for 2.3 will cause warnings with pre-2.3 clients
connecting to a (hypothetical) 2.3 server which does not send "proto",
(or vice versa).=20=20

What could do is to add some more code (sigh) to make OpenVPN 2.3 *ignore*=
=20
proto mismatches and missing "proto foo" strings in OCC, and stop sending=20
it in 2.4 altogether (so a 2.3<->2.4 combination would not warn, and=20
if 2.2<->2.4 warns, put it into the FAQ).

Maybe we should also add the same time stop warning about tun-ipv6 mismatch=
es,
because the case where there server has tun-ipv6 configured, and the client
learns it due to "push tun-ipv6" will cause a useless warning today...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--TlGginnuNEm5PkhK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUL5dvKkuBuNlUUl1AQJiRgP9HwgO9MBwF5XGYy/XlBuaTkXGzm0f84s+
hBPEWHbw36vVjtCvihSKdAzRJhB76tYJuHVLQ6ffp/YkVb+9LDjzhafuS8pGdFVj
Nuy354182PXVb1nmbzvoNCfBbCBLi9jByTxdLNV4Dyj8YtU645cGPlM3z1J9sh5T
1RfOrNGfUyM=
=yQZL
-----END PGP SIGNATURE-----

--TlGginnuNEm5PkhK--

