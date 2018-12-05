Date: Wed, 5 Dec 2018 22:24:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181205212453.GR962@...1296...>
References: <20181205210734.62565-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kYGXewcsBUFveVAk"
Content-Disposition: inline
In-Reply-To: <20181205210734.62565-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Stop complaining about IPv6 routes
 without gateway address.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--kYGXewcsBUFveVAk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 05, 2018 at 10:07:34PM +0100, Gert Doering wrote:
> The IPv6 routing code inherited assumptions and the message
>=20
>    "OpenVPN ROUTE6: OpenVPN needs a gateway parameter for a --route-ipv6
>     option and no default was specified by either --route-ipv6-gateway or
>     --ifconfig-ipv6 options"
>=20
> from the IPv4 routing code.
>=20
> This was never really correct, as no gateway is needed for "into tun
> device" IPv6 routes, and the "--route-ipv6-gateway" option it refers
> to also never existed.  (Routes on tap interfaces *do* need a gateway
> due to neighbour discovery being involved.  As do routes on Windows,
> but there we fake the gateway in tun mode anyway).

Mmmh, ditch this patch.

I've forgotten the patch from James Bekkema (which was sent in a weird
format so patchwork did not recognize it as such).  Both patches are
compatible, but my new message does not take this into account

v2 coming tomorrow.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kYGXewcsBUFveVAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcCEIkAAoJEB2Cnv7KVigSUCEMAJhqwzwNrrz8kBuTkGU2ve7z
fmLzdleza6P1r0i9lLbf1EgCwDK9P1TBlQPNTTS7/dW8ZSziVsMFn8HbE7ECoHw+
Ba41Q0j2ej7VQOEzppfXLA82javRgc2T/HrbQGeqkR9bKk9h8/UfB3n9ubCyUZiH
aVDPWEIuFuCLNZkH3HWmxJpmO4rrLQyZrmWXDyoV3Xe8otLYjbpX3FR7eUZ1hl+A
V/jtXWuG1dK4nNL3yXUdhyhI1UlZSEgJnDpZb7sVPiM5OC7vlhH2s86ihPPoLBG1
j+oc4YQhnN1lq83XkLRFBWM640198IsOUAIsYhwgKAqpOW4FVCtju07TDWznzt7n
lY/iuJBICQwNxl/FrkShrG16ROc2lwm5Hd2AVHLRxS6fMbNkdEuDfaWQuIWjDAXD
fUCokO86gehrNELiFccL9wdAh+HBvOHMJ/GldAppzmJJHr9RecWXstBEw3D0v2zC
dkNHADpND0Rmz3X9HOXR992D9nixiA211m6CTY513g==
=nYvY
-----END PGP SIGNATURE-----

--kYGXewcsBUFveVAk--

