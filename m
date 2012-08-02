Date: Thu, 2 Aug 2012 15:45:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120802134516.GM2535@...1296...>
References: <20120801203832.GK2535@...1296...>
	<1343914619-10576-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Content-Disposition: inline
In-Reply-To: <1343914619-10576-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Merge almost identical
	create_socket_tcp and create_socket_tcp6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 02, 2012 at 03:36:59PM +0200, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/manage.c |    4 ++--
>  src/openvpn/socket.c |   53 +++++++-------------------------------------=
------
>  src/openvpn/socket.h |    2 +-
>  3 files changed, 10 insertions(+), 49 deletions(-)

ACK on v2 of 3/4.

I think this can go into 2.3 as well, it's basic cleanup (and in addition,
it's cleanup of new 2.3 functionality, so doubly welcome).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUBqEbKkuBuNlUUl1AQIKzwP/UJJ0LU3krIHpg2zWXLXL9461QFElA85e
5Bqq5C2syZ0GUPi1yJ0SQ7yPO0XTGi+rpGPNHxbvJ6GqwSqvS++kNaijXUKvEf8O
P5twnL/3aR4KUY4lyNEDIZXlLa3ClB8rtJIRCMhH3GITIc7C+GUChJIwcl0CR+uq
DJmdn0pTZKg=
=PQTV
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--

