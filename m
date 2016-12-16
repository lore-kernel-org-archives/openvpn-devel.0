From: Matthias Andree <matthias.andree@...68...>
Message-ID: <a0cc9f56-0a28-fdbd-22af-c2c524c9b36d@...68...>
Date: Fri, 16 Dec 2016 21:21:07 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="uMh8vaLQViQt5m5aqnvNSQVIoAlm2f6Wx"
Subject: [Openvpn-devel] CFT: OpenVPN 2.4 port update (upstream rc2) for
	FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uMh8vaLQViQt5m5aqnvNSQVIoAlm2f6Wx
Content-Type: multipart/mixed; boundary="v6Q5rhcDI5JC6dlpqwIn6mtQhghsf7mCm";
	protected-headers="v1"
From: Matthias Andree <matthias.andree@...68...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <a0cc9f56-0a28-fdbd-22af-c2c524c9b36d@...68...>
Subject: CFT: OpenVPN 2.4 port update (upstream rc2) for FreeBSD

--v6Q5rhcDI5JC6dlpqwIn6mtQhghsf7mCm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

I've put up a new OpenVPN 2.4-rc2 port for FreeBSD for testing.

Get it from <https://people.freebsd.org/~mandree/openvpn-2.4_rc2-v1.tar.xz>.

This time, it also contains the openvpn23 and openvpn23-polarssl ports
(as modified copies of what we have now) that I plan to keep for the
first quarter of 2017 and then retire, just in case.

The diff at https://reviews.freebsd.org/D8813 has been updated, too.

Cheers,
Matthias








--v6Q5rhcDI5JC6dlpqwIn6mtQhghsf7mCm--

--uMh8vaLQViQt5m5aqnvNSQVIoAlm2f6Wx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYVEy0AAoJEOQSsVbv84Vaq+gQAJr8s3voMAzV5p1XUx1uNByb
NHHkjCcyKbd2cR0FzAZzcd6t0EzKjyke21ImJaCR1eplXkevrb3miXx/Hd5JtHDF
m2WAvi7Xv5Jp3NLE+kFftOnGNjDV2M4I6krwLnDlJGBpUkzh1N1ulVUwd/ftJD8U
9Nix0RsyqJnC7uj9ryps4MhjfVS41t8u1XOUANgyIMfIR3WBx8kx6u++UHUVUvMu
m7Ssu8oOPO46B6cNUJ7gMcgcf/XtNQ4mJWxsUjPFlfaHP9CRRMmGVce9pSz5dPGQ
JCPUHWDvtlgcSk2omF9aOVbZCEj1+b88KwxCS5iWdldweI6Bmy9VotlEUM3/O+kx
QFU+M3JmsbqyLhyWK5HBjfq+yZf0NqcgSCqCQKquC+injQT08fQJIrXF0Ss/YdnP
fftWVe9T3zOabqRyxX678pM7AxmMiDLNsHz8KCu2p6nAClRKSI0Dl7upwrIUwBrx
5CRK2hdO4T/AHoedTkhW8t4CzcLMgSKCviBDiL52Y+2jKJVL1kBu7n1WaYAQJ2Vg
NZEqkt2E7w8sjU6UeZ6/zWkAEqvSTZ/sNAq4oA4o3A2/ggGp3+2imUKFDySi6JTP
mVYUNRn02ijCY579G9jSjdHwVc4BRGobgVSV/pSCqYn/JUgUuDYBAvMMkxctjgOe
2qiNd0+Gy2+GMjedvZUy
=zFRz
-----END PGP SIGNATURE-----

--uMh8vaLQViQt5m5aqnvNSQVIoAlm2f6Wx--

