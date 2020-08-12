References: <20200722132852.48508-1-gert@...1296...>
 <20200723121949.78223-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ee8b7463-f3d0-401e-815b-72bcbe6723a5@...1227...>
Date: Wed, 12 Aug 2020 11:43:27 +0200
MIME-Version: 1.0
In-Reply-To: <20200723121949.78223-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nMfmckGeuIxtwgJ1XtBGFi5UnJkEKiskW"
Subject: Re: [Openvpn-devel] [PATCH] Workaround FreeBSD 12+ race condition
 on tun/tap open with IPv6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nMfmckGeuIxtwgJ1XtBGFi5UnJkEKiskW
Content-Type: multipart/mixed; boundary="bJmtBWVfifcKll0ESedlrvdTB6GxjHmIO"

--bJmtBWVfifcKll0ESedlrvdTB6GxjHmIO
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 23.07.20 um 14:19 schrieb Gert Doering:
> On FreeBSD 12 (tested and verified on 12.1-RELEASE-p2), after "ifconfig
> inet6" for a tun/tap interface, there sometimes is a race condition
> where the "IFDISABLED" flag shows up after a short time frame, under
> a second, and never clears itself.  This disables use of the configured
> IPv6 address on the interface, breaking IPv6 over tun/tap operation.
>=20
> This only happens if ipv6_activate_all_interfaces=3D"YES" is not
> set in /etc/rc.conf - but there might be reasons why this is not so.
>=20
> As a workaround until this can be fixed on the FreeBSD side (or a
> better workaround is found), sleep(1) after ifconfig, then call
> "ifconfig $dev inet6 -ifdisable".
>=20
> Yes, this is massively ugly but makes the problem completely go
> away for my test systems.
>=20
> (The same effect can be achieved with an --up script that does this,
> but it's even less pretty - see trac ticket)
>=20
> FreeBSD: https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D248172
>=20
> v2: reword text, refer to FreeBSD bug with much more details

Acked-By: Arne Schwabe <arne@...1227...>

This looks like a ugly workaround but if it is the best we can, so be it.

Arne


--bJmtBWVfifcKll0ESedlrvdTB6GxjHmIO--

--nMfmckGeuIxtwgJ1XtBGFi5UnJkEKiskW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8zub8ACgkQFRhsZwKx
RFR+Zg//Uqk8sh7vhS2p84q+aNnklaV212KO5boh4wBs+2Qv5d203S/sLNdhAS6Y
L+qzLUEgRos7kfSupjccZVYKiJN6/LSY7DzXOobUeykfpxjmf2xCaXyd7SbsWxG5
yjR2Scey5Gx8slNxAfUStDQa1Hu2xTWTbTg/sYEQbnQYPMhCEd5QqtzP7V8FSHEa
xZ8xWSQOpeb+wkGVKstsdlveLaSUpwGbJabhbZf633AYKZICO2YE7EgDziP8v1fi
xJ7CbezWKut3WKAyd1I5Wh74LyF+VWggtFdUKq4Vg8RVQdr8Eu3Rejl/NFAxlhSI
MZ9l96tcjtQjUcQpL62c2gWNSIKU7XcNRXSgJ5CfYADFDKUUM3wqJWAOnkxMYlIn
j1J+mpDiV8IJ9n7qorcaSqJsXdX/TXlrqsS1SkEkXTyjYuHMAv/UmRCnGfLbHIPG
QLzqU0ZgsLmahDgjn4oWG3GeGRh4Lm9YrH0afLOLNYTMmYDOqjRm5RcDMfpwHZ8O
vDiIkWZQ3LxjxO+l9KEvCZGKZ9LvHd71oOcyeKVd4okqAOozfvs4VSfzpYfD8EHU
vhjChrLFzHJzskcay5aIU6MctCvp+aW96YtgyzMrLvHqHI86mjHWxX2ixzYGIivI
30HPHlgIYW3hB7JZcjQkqwYX1xyM0hoTAxht5TJdFrJHxV0SwOU=
=xfmw
-----END PGP SIGNATURE-----

--nMfmckGeuIxtwgJ1XtBGFi5UnJkEKiskW--

