Date: Thu, 7 Sep 2017 10:13:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170907081340.GG70062@...1296...>
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UNRiu6AvOPumrTuJ"
Content-Disposition: inline
In-Reply-To: <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

--UNRiu6AvOPumrTuJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 07, 2017 at 11:04:01AM +0300, Samuli Sepp=E4nen wrote:
> "Note that units which are configured for Restart=3D and which reach the
> start limit are not attempted to be restarted anymore; however, they may
> still be restarted manually at a later point, from which point on, the
> restart logic is again activated."

Which is not what I hoped for... "turn it off and leave it so" is non
helpful (it might be a transient error preventing the startup).

Meh.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UNRiu6AvOPumrTuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZsP+0AAoJEB2Cnv7KVigSrcMMAJv0z24CuhCRCBVUEkjFDzL7
McAnSdgntGeYKNzj6mEK+uFA3UO7ets8gqmAhuRrC8ROI2qqZvxQKonc7PtMNZVA
7ojCurmnox2aVazFgSzSdxqJ3MzajMmL6zQcXb4kGDIqHjs/SdRjFuir/SoXmrZp
4MqQL2RTTNM5pGToKDc7GEEnFEWKz31nOYHrM2bgIrjfV11KHuRPsIiBQQnggr0j
VBVBwFYk6c7aKQgnunmjQVPnUv2Nadnrp24zDIMTruCPpXCsxleRNxAeb5R1awXG
QaYzBk34KMLq3xXc+TuzGo5v1W5RrUXQBS1+zlF4DM5zEdu/7yT0tePaDDD0dIeb
Dd8Yey/jo+CAiu2pxTrLnU5HuhfMC5MNTcdunz8T+KJzpm6mjdPoi916Y1y1Li6z
UJy9MVK/s5va18rv1G/MJuy+e6JoKbqhtA2EeDOnuoVJ3nV1HmKj17f19ETPo+FE
JaTb4bSehC/AGo2TMSCiWw0SreguJarXVB0EZ9F9Jw==
=R2JF
-----END PGP SIGNATURE-----

--UNRiu6AvOPumrTuJ--

