From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <810d1bcb-1a97-4fbf-aaf6-b05e524a643d@...515...>
Date: Thu, 2 Jul 2020 21:33:24 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iPnPL4Wh3QynrTlWj1kPF8P7l7EAOyD0U"
Subject: [Openvpn-devel] OpenVPN 2.5 MSI installers for Windows available
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
--iPnPL4Wh3QynrTlWj1kPF8P7l7EAOyD0U
Content-Type: multipart/mixed; boundary="3V1uPTkRP3GBp3Qpt2GsR4g37T6S6kBLc"

--3V1uPTkRP3GBp3Qpt2GsR4g37T6S6kBLc
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

For anyone who is interested: here are MSI installers for OpenVPN 2.5:

<https://build.openvpn.net/downloads/temp/msi>


They have been lightly tested and "seem to work" on Windows 7, Windows
10 and Windows Server 2016. Windows 10 on ARM64 fails driver in
installation, but we're looking into it.

OpenVPN comes with a number of big and small changes. Probably the most
authoritative list is the "Must have" section here:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

The MSI installers bundle both tap-windows6 and wintun[1] drivers. If
you want to try out wintun add

  windows-driver wintun

to you config file. As the name implies wintun will only work in tun mode.

If you encounter any issues with the installer please let us know!

Samuli

[1] <https://www.wintun.net/>


--3V1uPTkRP3GBp3Qpt2GsR4g37T6S6kBLc--

--iPnPL4Wh3QynrTlWj1kPF8P7l7EAOyD0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl7+KHQACgkQKVhNn0CG
RXjSgQgAlH1eq1jYnLUWLgzCl+MxjljGsYy2Aa+avhNUuL6GGj3zmaHzPN2Mnzbu
emuP4F4QSHHuNMP2T9dYV+t23XpOd+bl4QYEq5E/gKw79nQj6GjPUAF5ZdG+lq1W
hrJTYv6CwzzN8GwHSIwQJiGFBCkfgx9/4Eql0sjnBZd5LVptIvClA7g995pTm+ha
c2IiCxpbwG2hH65DzYPEZK7PyK52Vb4IgAwVl3Ngva1DoQucL1G34fuh2sVqjyFk
IbP5HbavhLpOMFvJ9QCu3m4e3g71ECNky7RFZ0oh5LT8aFOFRUKPnREC/oJGHyGs
38a0j9KVq5vb2wTN7EXHl/aiT3qwIw==
=O4jk
-----END PGP SIGNATURE-----

--iPnPL4Wh3QynrTlWj1kPF8P7l7EAOyD0U--

