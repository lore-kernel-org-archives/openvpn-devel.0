From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
Date: Sat, 20 Apr 2019 12:16:49 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OLfREYvLpixGuLVYwhDxTwW80yhqOTsf4"
Subject: [Openvpn-devel] New OpenVPN 2.4.7 installers with tap-windows6 and
 other componets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OLfREYvLpixGuLVYwhDxTwW80yhqOTsf4
Content-Type: multipart/mixed; boundary="kl9N6oF6QAHTa6I5qTBjqSnZDl5gploDM";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
Subject: New OpenVPN 2.4.7 installers with tap-windows6 and other componets

--kl9N6oF6QAHTa6I5qTBjqSnZDl5gploDM
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi all,

Here are completely untested OpenVPN 2.4.7 installers which I wanted to
get out for testing a.s.a.p.:

<https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604-Wi=
n7.exe>
<https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604-Wi=
n10.exe>

As the name implies, there is a different version for Windows 7 (plus
8/8.1/Server 2012r2) and for Windows 10 (all versions). This is
necessary due to code signatures in the tap-windows6 driver.

The above installers bundle the following components:

- tap-windows6 9.23.2 (many improvements incl. arm64 support)
- openvpn-gui 11 (latest from Git master)
- openvpnserv2 1.4.0.0 (latest from Git master)

If you want to just test the tap-windows6 installers they're here:

<https://build.openvpn.net/downloads/releases/tap-windows-9.23.2-I601-Win7.=
exe>
<https://build.openvpn.net/downloads/releases/tap-windows-9.23.2-I601-Win10=
.exe>

The latter installer _might_ work on Windows 10-based ARM64 devices, but
that has not been tested at all.

I will run my pre-release tests as soon as I can, but probably not
today. Any help in testing these would be most welcome!

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--kl9N6oF6QAHTa6I5qTBjqSnZDl5gploDM--

--OLfREYvLpixGuLVYwhDxTwW80yhqOTsf4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAly644EACgkQKVhNn0CG
RXgH6ggAvI0W6bS/BZYtJWbbCCykG//A/NJloxdvwMgBmwff+zkbwJUKZwHUQVAi
xub/0+PH2VtWCM4xXpbSzfNzRZVeOfpuzWqn+TDcQ2hPSkkbabmvnuLj3dCm7cYN
VZkDFDHiABSn/yBH76sLYmmh3qHCYL/JzgWnQNujtg5thL0IItz1+PTSpJj9Y9Xc
637NNIVSkMBhg4DNL+CKIU+FRMDT42pq0eJS8U0kQOOJS05J6/GKbIoxiL5DDfR2
6e1D31R3OZmNSbiaEdBg9UhYea/P38fApdvMGkPNeG3XzUbqcgcVXwoEHRMtZeD+
PbBeG1BCWPk7dS5IiD+dAR8igNomrg==
=qaks
-----END PGP SIGNATURE-----

--OLfREYvLpixGuLVYwhDxTwW80yhqOTsf4--

