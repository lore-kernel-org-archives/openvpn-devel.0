Date: Sun, 7 Nov 2021 14:55:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YYfa3rAEKJKQ4RpK@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BDMJjjHIY8vHtOEw"
Content-Disposition: inline
Subject: [Openvpn-devel] NTLMv1, NTLMv2 HTTP proxy support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--BDMJjjHIY8vHtOEw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Community,

OpenVPN supports HTTP proxies that require NTLM authentication,
supporting NTLMv1 and NTLMv2 protocols.

This is old code, which was written in the dark ages, is not currently=20
unit/client tested, and uses DES which got deprecated in OpenSSL 3.0.0...

That said, if people still *use* it, we are likely to keep it - otherwise
it might just become lost :-)

So - if you use HTTP proxy in OpenVPN, and that proxy authenticates=20
against a Windows AD domain, and you use NTLMv1 or NTLMv2 authentication,
please speak up and tell us about your use case!

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--BDMJjjHIY8vHtOEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhh9reAAoJEB2Cnv7KVigS144L+wVwVj7Ov52wHer9Fj6u6MhD
B8T/CJva3IgG0XPrvJiQAmJfOIi9HuXCji+zHi9uojTj6bxh7t0e12dhfckyZ2kV
EIYJCgZVwRoD3Vi4JE/CQeCYXPHRC39wTA14WKDMFaamwQq2IapK0k+ySJXN7Hp8
xnBklaGB9eteC4318PkQmHrdG9EsyHU82XJbzQqhPiVwIx60f+0GB6LwcN9xnnpb
MJQV7/agrNW66tp30DJprc4SAXfNRT1BsphD8qQRb2FA5J3bDBQwxYiQom/vhuUh
xXCMHAYekHILQrBqXkWs1l2F7GmqqEZcm8Ey4sOJahsKGuZFE68TaeGSyWgtmWKH
vadoj027/md3TwqAlCbsTnGRQpin/F41GrAnyfbhBexDLBdzuyLYneWSV/aG9HnQ
VhD8c/vLldJrELFSk/xx9sz3NXIEAf8dQsukBBqdBaLZDzAi3dwB5pLQh41VyQYT
U/9McYgiIDeI/KK/JoygD6VeJlZA/qQcfRLc0QWlLg==
=cJlr
-----END PGP SIGNATURE-----

--BDMJjjHIY8vHtOEw--

