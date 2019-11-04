References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
 <20191103204613.GE40538@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a991a966-039e-c171-7201-01b90a23d2b7@...1227...>
Date: Mon, 4 Nov 2019 17:28:25 +0100
MIME-Version: 1.0
In-Reply-To: <20191103204613.GE40538@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DGSSWVlaEYYbtahHs70iBuiJHA1yT7qk8"
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DGSSWVlaEYYbtahHs70iBuiJHA1yT7qk8
Content-Type: multipart/mixed; boundary="dxEWPFKUOSo9YpQRnbJuTuVqJsvZwQPWo"

--dxEWPFKUOSo9YpQRnbJuTuVqJsvZwQPWo
Content-Language: de-DE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

 >> Yeah the removal of the p2p topology was one of the reasons. It's
>> actually the fact that ics-openvpn doesn't really parse point-to-point
>> ifconfig that made me aware of this.
>=20
> I wasn't aware of that, but since Arne is reading here, maybe he can
> comment on it.  It's possible that the Android VPN API just does not
> permit p2p mode, but wants a subnet.
>=20
> Arne, any idea if /31 works on Android?

Yes. But Android is special here anyway. It always wants a subnet mask
but the mask can be also be 255.255.255.255. And you also don't have a
gateway address and Android also does not set a route to the tun
interface (On Android 4.4+). So basically you always operate in p2p mode
and emulate other modes by adding routes to the tun interface.

Arne


--dxEWPFKUOSo9YpQRnbJuTuVqJsvZwQPWo--

--DGSSWVlaEYYbtahHs70iBuiJHA1yT7qk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3AUaoACgkQFRhsZwKx
RFRFtg//UktYhqtNeEEnQwesly4CfX3zoRIgrZVX40j7vN7ICl5/PCHt/6LUEaqt
MoQag0T55XQ5fB40sfrExnhlIrk9MHiTtUqQEteoS9EWJMGRWUU+DkKTqhWksqKu
ScZmT+TeTfea5UJLfScEY+oWBKzlE0knI2L6bcb2kwOnMcOj6cf8wGpFSfSs8PSP
EzlCLDB0y473oSik9dkzTJOC+QBV1hMslixzbIbMpYwx+yb2E0ShhW6AUGJg4xVN
emBzGWEmj/X7ie6T8mvEJMaxBUrcXg5Eewz+Vt0RB9J53sGEIlN9wk+tiUBO+V6Y
4oxmu+79xorCBxdUdvNJqdVCN/X8SxoyF1Ar6y8ZRlKsc2MMh9jJGf/xyp88OmG8
mQfm8N1Yp7+pTp/2YHO/sXwo4jvshPhqDl8Ma7Tdfnr9GHHlbyZMECVspoHBHwIG
68ePW/440hIcnNyZb7x3B1J+5RxWwgxx/CdAI0a0B3jKGHZlgS5oF0lT049slkZ7
xhU60G1tJ85GbhI9FwM6c0h+FOQJDyd3bPml0amz+hCuBhs6ApQC06f3DsI4gSnR
Q9VC31tUOfg1ULNVj7vVo8XW18mtFCWFfB+u8aszPrqmP2MmNrGB0rVxuzHA2fZE
+7OLWkf3yvcLKiFkGHKZgis74Gje89vsbWQlImhGpMi8qsQSC8s=
=odfA
-----END PGP SIGNATURE-----

--DGSSWVlaEYYbtahHs70iBuiJHA1yT7qk8--

