Date: Thu, 29 Dec 2016 22:02:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161229210244.GR78624@...1296...>
References: <20161228185700.GJ78624@...1296...>
	<20161229185727.17020-1-list@...1798...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U50CbOr64UnCgK/4"
Content-Disposition: inline
In-Reply-To: <20161229185727.17020-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] move systemd specific code to
 platform.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>

--U50CbOr64UnCgK/4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 29, 2016 at 07:57:26PM +0100, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> We have voices that do not want to "litter ENABLE_SYSTEMD all over the
> code". So move the systemd specific bits to platform_notify() in
> platform.c.

While this is better, it's still far from a proper abstraction that could
be used for cross-platform notification - like Selva said, we might want
to add windows event logging eventually (quite likely a larger user base
than Linux)...

So, for a start, passing arguments to platform_notify() that do not make
sense to anything that is not sd_notify() is a non-starter.

Then, please investigate using the existing status file / management
interface code to add this, instead of adding new calls in init.c
(I mentioned this yesterday).  If our existing status file / management
code is not up to more fine-grained notification, I'd rather see that
one improved, and then call out to systemd / windows events / ...=20
than new code in parallel to the existing notification code.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--U50CbOr64UnCgK/4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYZXn0AAoJEB2Cnv7KVigSe+cMAIjkloTvAv6aWV08ZzjrDIbn
f1l+M1yMoABzb1rXrFRpDZIfIxgaQt24dWp93BBUyFbFyttmPc/BIxMsOEUCLNTN
iwcSKOMITXosMi86ZVGmWaXxYhX94a/m2NIQHhLJ+K1iEPKpCls6rPY563Iu2UNN
HUH6SK3m9+M8q018rlGr3s/luXa//nOYZgRSIkbJ2Oy0MKIUA0lDV4gac1SAiKfB
CifMKUQFCZninXWGDZR7pcnrnZOmJ1NvCgQlSGhomwZ3K3lUVP6Ts7+6kp10otPs
IL/oVtxrN6Cng6z/y8XDYbLAgA6WAqNQBQ7f6x7wODxYS1L2Otga4w4GESxu+ZtA
50vXNwCHIgRg5SF9Rg5JBjYINXMXjtlhxZI4XpcyT4AsrqDunHA/9uELrmQCchj7
rkP7I3CDhPInhPhCAsSHB1hN/rFIT011muBpOCZYBHk8QQHd784jIJWZVbrSHsWw
LRbmf3GcK5i+kQPhswLMwIVfynz4g/8OEiBghjCMXw==
=IQKG
-----END PGP SIGNATURE-----

--U50CbOr64UnCgK/4--

