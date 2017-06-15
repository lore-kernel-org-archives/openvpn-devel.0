From: Jeremie Courreges-Anglas <jca@...2272...>
References: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
	<20170612134330.20971-1-logout@...260...>
Date: Thu, 15 Jun 2017 14:04:20 +0200
In-Reply-To: <20170612134330.20971-1-logout@...260...> (logout's message of
	"Mon, 12 Jun 2017 15:43:22 +0200")
Message-ID: <87h8zhmp8b.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH v7 0/8] OpenSSL: support for version 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: logout@...260...
Cc: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain


Hi,

fwiw, this builds fine against LibreSSL, which seems to provide some but
not all of the functions for which you wrote fallback implementations.
LibreSSL as shipped in OpenBSD-current, ie the development version.

make check passes, openvpn seems to behave correctly in client mode.

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAllCd8QACgkQDfp0rhUk
5+6AKw//R0E6YLHZvj96gyfl/5FWBE6PN7BqvYh8YAI86uOFJLzXvx8xQpPF75gN
u6PBCYaeKQ2HrT+39phsDNMNNrje4mJrUj+kYjZnsd4OJypzGW3p96u0+yO5zKeZ
JU3p3Z28dm7ZCtMlnEUK0vVAdrysiUskJKe21+lfeK0aYVmtSL97zJY9xe0cuQRc
YU/FS1x7d4+LD8LInabUxTlQmEMFIgSj2EKVdD3ejeQ54tf5l24E8tG83crt+PUB
qW12N4jmkN6uMrdbIGOF3mkJE+pr6446iYZ7Fz6ATRE0kC/+OLh6ziH9UqlIqQd8
FHlXPCbAMKocxwvMYbXy8OxZUEqKZmSRPMAGUf+OKpzWARMPccBU/ueqcEUcr3ub
MQRw1z5B9SFzkD9nlg//aQdLXaxXKBmUR6yQvwEqp35t+gj1xv7Su5Xn+DwVObb4
1j5Fx1s1SA8MrkO+j2oSWfqhEKLW+GQihSYqLV5FiN0xUBBPvv6D5OBEZIviSt84
J4LBlw8lLgXj0un6VNHRyHy3agmjoLQ12JpygvVGbxKsUemXVa0QajwaTbxWxnsm
CURzRWpP/h98YZOzQYvTaJmZ8Tz6z/v5iQeC0jxgEy1vgi39ckXhiHmwhMspznFv
gQKkOqGE2MFOaM96FEhWbwfiEgtbPBQb1502VFjXHO1uNEN09AM=
=9Q7B
-----END PGP SIGNATURE-----
--=-=-=--

