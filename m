From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <70f8e104-6d26-b1e7-12df-50f88d02cd74@...515...>
Date: Wed, 23 Oct 2019 14:19:32 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g1BR4VNbryigMaLWTxrgeg7fftFRdw7SK"
Subject: [Openvpn-devel] Tap-windows6 test installer with PRs #84 and #86
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g1BR4VNbryigMaLWTxrgeg7fftFRdw7SK
Content-Type: multipart/mixed; boundary="WUCJMAanldlK7lmf5tET3Uhm47JbYopQZ";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <70f8e104-6d26-b1e7-12df-50f88d02cd74@...515...>
Subject: Tap-windows6 test installer with PRs #84 and #86

--WUCJMAanldlK7lmf5tET3Uhm47JbYopQZ
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a new Windows 10 / Server 2016+ tap-windows6 installer. It is
based on the latest code in "master" plus two currently unmerged PRs:

"Introduce TAP adapter as a virtual device"

<https://github.com/OpenVPN/tap-windows6/pull/84>

"constants.h: make driver not halt on suspend"

<https://github.com/OpenVPN/tap-windows6/pull/86>

I have smoke-tested the installer on Windows Server 2016 and it passes
the signature verification just fine.

We hope to later merge these two PRs and push out a new, official
tap-windows6 release.

Samuli


--WUCJMAanldlK7lmf5tET3Uhm47JbYopQZ--

--g1BR4VNbryigMaLWTxrgeg7fftFRdw7SK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl2wN0QACgkQKVhNn0CG
RXjw3wf/ciokA8AAkOGX4NbQXWRD3b04ql4Ngr6x0DaiOoHxXF3kKWgCohXy5ltj
KhVeFrwGJZK+t29zwsedQbJw62yWM1/iBllMp+DBQlLHO6pqUfV/ub2SCLUTcwa4
BYAXch7zR2GMNSl+iJaBzqmr04kCgyYOZaPRvrfpUii6LdHYQm1D8IdguWMGG1b7
ATT7kdOQ8bQPcDy/qYnZCIsvPawO0eZBKgTyzYI7iQeaaORsOSOb013uVfhX8bvE
9+de6HZocYZyfX1HnzNOhH+jnuqsGifXz5SyGXk3IEhmDa0mIuQSdDIXh07T+DVt
VIq29Wbw2j+9l09EGV2PaG9cxrBnmg==
=fKRd
-----END PGP SIGNATURE-----

--g1BR4VNbryigMaLWTxrgeg7fftFRdw7SK--

