References: <20200717171036.20687-1-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6062d64c-14ef-0e0d-4e83-925b79b4900b@...1227...>
Date: Sun, 26 Jul 2020 02:01:51 +0200
MIME-Version: 1.0
In-Reply-To: <20200717171036.20687-1-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MzffI6yGI1KG5WzmDdzG8WW3xWAXTvu5s"
Subject: Re: [Openvpn-devel] [PATCH] Remove --no-replay
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MzffI6yGI1KG5WzmDdzG8WW3xWAXTvu5s
Content-Type: multipart/mixed; boundary="DoXTm5zaRol3sHZVSC67jFo1T98Zs9tKh"

--DoXTm5zaRol3sHZVSC67jFo1T98Zs9tKh
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 17.07.20 um 19:10 schrieb David Sommerseth:
> The --no-replay feature is considered to be a security weakness, which
> was also highlighed during the OpenVPN 2.4 security audit [0].  This
> option was added to the DeprecatedOptions[1] list and has been reported
> as deprecated since OpenVPN 2.4.

As a side note, removing this feature weakens the ability to use OpenVPN
is a pure tunnel without crypto (--auth none, --cipher none and
no-replay) since this removes the ability to disable replay proctection
when no authentication is enabled. (replay protection without auth is
silly as a attacker can just fake the replay id too.)

Acked-By: Arne Schwabe



--DoXTm5zaRol3sHZVSC67jFo1T98Zs9tKh--

--MzffI6yGI1KG5WzmDdzG8WW3xWAXTvu5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8cx+8ACgkQFRhsZwKx
RFTdmA/+IXz0gdt/eAHGdMpHx+xgO9de5/NgfgTv7ERgsN8nAc6Fj6WatAmIt3CG
8c0CqUU84UUIg2ADHrTCO0qE48Es8kd5lmVxJIl/67u9ZozjS7nbCRx8mfLu5E/u
uPqaLc/18rcjRiFbeyM6ZcvGFMc8Qq1QZdfrWVlqrrPz6N5y6xXLCwXFu3LWpXuq
6iAYmAfCANpWb4qdJfegSgbulfIyWEFaV9i0p+lvw7q0MptV0kolmc65Sm3jxUJh
P6rVTNrkhJtxhwg2jqPlM4yPKhPVJyhPzGMLbvswiIDhPNw/+BdYs2EyI5YEdSj/
lk5xFW3xHUgU+ZbGfreICd7Qkgdq+ocO2ELxqJNCkb649atZ5nA5I/VucOWOxfSz
SI2HPftsvnVlIWq76H0qxZA+kapomXjKYBlg4XgDP58LPTOL7/ND3dbB0S9Jk21x
cLtnStrTSuB4SLn7/noqxtyQQ7tbveK/DXV3Xn4BeiNO/oB+BPGzmfqFaUEi3RJl
7ESD29Mzu1kbw3Spf9wAMHMr5nlFvzC6zXEhQd95FWS9ol7WazfQUhn6hMtIGmRU
0t0FQsQ5dKLLruxbyYgq2nZWopQAFmddGShANk0qhyuK449lEqFm2Ohq77jsbtFB
7XsVeCSb74sPvEIy/wzLW/1SRGZtYZx+n9Vt5vNrrQ0tVdFSok8=
=ehJ/
-----END PGP SIGNATURE-----

--MzffI6yGI1KG5WzmDdzG8WW3xWAXTvu5s--

