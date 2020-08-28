From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f10b3cfd-d020-5598-ec84-95fc8cd0e8e9@...515...>
Date: Fri, 28 Aug 2020 16:09:59 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sGwZNhN1kwoj18EhfiMzN7f0wBC9czMB1"
Subject: [Openvpn-devel] Help testing OpenVPN 2.5-beta2 driver installation?
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
--sGwZNhN1kwoj18EhfiMzN7f0wBC9czMB1
Content-Type: multipart/mixed; boundary="fnFAsdLv594x3sSD975oH0OqElo8px2FY"

--fnFAsdLv594x3sSD975oH0OqElo8px2FY
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

It would be great if somebody would find time to test the following
installer:

https://build.openvpn.net/downloads/releases/OpenVPN-2.5-beta2-I601-amd64.m=
si

In particular I'd like to know if anyone else has problems installing
Wintun or Tap-windows6. My exact issue is described here:

https://github.com/OpenVPN/openvpn-build/issues/187

At the moment two people have successfully ran that installer and one
(me) have failed.

Samuli


PS. The installer has a known, upgrade-related issue as well, but we
already have plans on how to tackle that:

https://github.com/OpenVPN/openvpn-build/issues/188


--fnFAsdLv594x3sSD975oH0OqElo8px2FY--

--sGwZNhN1kwoj18EhfiMzN7f0wBC9czMB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl9JAicACgkQKVhNn0CG
RXgTUwgAlzN4GrmYRsOWGzxmJ1/jNcJgruqUPasA2auRSPxaKrQwJYyEz3emfwPd
XwNTGu9YHoSHPxyoIVf9hgaZGICpxOc/5zW9V+lyAU5Q1i8l2EVKoNzustlLC8vj
M0mfLB6hwbepBT2hBVcnmra2yMQUaWeV2qVXDnGZma/0w5rqHF6P/zHTpd3qI6+b
DcFnm8KG39GoujyX4EjTsEUVDLRl8KXpNnzDn9gnY5HrJNpElX886dEkB0nFxClf
3s58NrMA9+sj7+SGeUmYSzTx9sGX/uLbs9b4kUH4DYmddLqCQqVdbrMCPJnYEeiX
vUO1NT1Reh45YHBUH0UPelg0XKatEg==
=1SiL
-----END PGP SIGNATURE-----

--sGwZNhN1kwoj18EhfiMzN7f0wBC9czMB1--

