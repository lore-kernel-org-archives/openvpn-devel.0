Date: Mon, 23 Jul 2018 19:39:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180723173923.GJ55859@...1296...>
References: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ceI9FlwgjS98XxYT"
Content-Disposition: inline
In-Reply-To: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
Subject: Re: [Openvpn-devel] Fix for NetBSD with subnet topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adam <adam@...1031...>
Cc: openvpn-devel@lists.sourceforge.net

--ceI9FlwgjS98XxYT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 18, 2018 at 04:33:13PM +0200, Adam wrote:
> It turns out, NetBSD needs similar handling of subnet topology for tun in=
terfaces as OpenBSD does.
>=20
> Here is a patch to fix the issue (against OpenVPN 2.4.6):

So, the patch looks good, and it works nicely on my buildslave.

There's two catches here - one is that with this patch format, I do not
get proper git attribution in place, so we really really prefer patches
that come out of "git commit -s ..." -> "git send-email".

The other catch is that this patch is for 2.4 only, and does not apply=20
to git master anymore (since Antonio has wrecked tun.c all over :-) ).

So what I'd really love to see is two patches, one for 2.4 and one for
git master, both coming out of "git commit -s" -> "git send-email" - because
that would speed up the flow tremendously (I can ACK and commit the patches
right away, but if I adapt your patch to "git master", someone else needs
to do the review and the credits who did the fixing are all wrong)

thanks :)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ceI9FlwgjS98XxYT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbVhLKAAoJEB2Cnv7KVigSZPAL/2rThJcDdXpKjlR0KFjRLR0r
dVoHxX7vOppgPGQDAG4BHBWWpIoGHAz6SozzGbCJyNDUQzYeM0WRa7CfQywC2Fhi
LJo7LVOCWpX/QkRgPpI9+2xfhhajDAoA2dV3NUQFuynWslASsHT7LF1dHcK0vE5c
i1xNAT3ozUiIFFQbAXdrg1dD/ZnbqI4wV3ZpkXMXzVRqWJ7C0iJBg1oJ9QuuLhjr
4kAk7pdWYj0/wQVFVp23XvJe/CAF73GmbniIjKfG9x0/kWpnKzC1kWFniRQ7BrK6
oW7e9I3iKa3a9XlhwoCtDYtG8Kv0UgyJe5Ls4RHZL+/fTK18OLyRSt5/z+3jbQns
M3GGz+oc4ZBKFPKM1UXu7q8AE9eUbG3AbhpWampHhrFnxKBrl1DX4tAR5sdSuf5Z
H8yx3Oka8KbueQ5ZG5LicLSDdYSpHbfH6hm+zPhrHQ9cfdYLjjUkuYrs1sY8lQ9V
HVgMXr7ZI3+pd5z7z3M5AAc/8uLXAtTlfJGblUiSvQ==
=A60Y
-----END PGP SIGNATURE-----

--ceI9FlwgjS98XxYT--

