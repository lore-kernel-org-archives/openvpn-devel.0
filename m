Date: Wed, 29 Dec 2021 14:34:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Ycxj+H3RexOHj6Oe@...1296...>
References: <20211207121137.3221-1-a@...2181...>
 <20211207121137.3221-9-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="e2BcToqSeIPZU6zd"
Content-Disposition: inline
In-Reply-To: <20211207121137.3221-9-a@...2181...>
Subject: Re: [Openvpn-devel] [RFC 8/8] ovpn-dco: force user to set
 DCO_INCLUDEDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--e2BcToqSeIPZU6zd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 07, 2021 at 01:11:37PM +0100, Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  configure.ac | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)

I think this should be squashed into the first patch, that adds DCO
support to configure.ac in the first place.

Plus, I wonder how we should do this in the first place - if we want
widespread DCO adoption, maybe we should include the necessary header
file into the openvpn community tree, and always compile "with DCO"
on Linux (if libnl is available)?

Having to fiddle with an extra library dependency *and* "you need this
header file which is found elsewhere" feels extra clumsy...

Alternatively, maybe linuxdco should just install the header file when
installing the kernel module?  How's this typically done for other
kernel modules that expose an API that needs a header file?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--e2BcToqSeIPZU6zd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhzGP4AAoJEB2Cnv7KVigS6nEL/3J2AiuqrnPuTZ9UG0VMH72y
ifbyj4z8Y/vVHG9KbSmJwcTOsCQaVJF4D5VEURMKnkjNvYTQt01kUG25c91kMpa3
aPutE8KL1hQWTlJe2c3MzoD+UCjRAjVQaODJHghMBq0C9cYPb3s9HJKLP/l3Ey0f
LwHh8tZdb75bR3W7wDpYiVdAHn10WFeW8BKwRITwm0KcqsFIbg7+KXo9lk8QVJ/i
YUIRcv6D8+magME+TGi3WGgsgzKq6wHbtkbxLRsqMDUqcwfy32Jj//KICt3/+doQ
XW/30YbLfeBNfudMjqj4+IAt8V+EABuplafVVr2yG6q6dcpE196b0yCUHIVOadAc
gq1gxmOpn+28rwgWorci0ApBzQ/Bj2QIs+C2DkBRDCBkmROHOx2hN0LhNJlTCPNH
nysB3ZWH3XkNL+jV/iM1ZONqrBNzLkKTL0vu2CyR5pu7PQiKl9We4dvZUOw/ZY7R
mi6Qr3ki5bbI7dTkNx7wR4HZbHNtJQ8agOPFvVIhEA==
=oQA9
-----END PGP SIGNATURE-----

--e2BcToqSeIPZU6zd--

