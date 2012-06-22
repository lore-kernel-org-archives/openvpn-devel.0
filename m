Message-ID: <4FE445E2.4070509@...1114...>
Date: Fri, 22 Jun 2012 12:16:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-5-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-5-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C61124197C616A729BD6FF3"
Subject: Re: [Openvpn-devel] [PATCH 4/6] Remove ENABLE_CONNECTIONS ifdefs,
 connections were always on for a long time. Not that
 ENABLE_MAMAGEMENT_REMOTE was only depending on ENABLE_CONNECTIONS and is
 removed as well
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C61124197C616A729BD6FF3
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 18/06/12 20:39, Arne Schwabe wrote:
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/init.c    |   12 ------------
>  src/openvpn/manage.c  |    8 --------
>  src/openvpn/manage.h  |    6 ------
>  src/openvpn/options.c |   24 ------------------------
>  src/openvpn/options.h |   19 -------------------
>  src/openvpn/syshead.h |   16 +---------------
>  6 files changed, 1 insertions(+), 84 deletions(-)
>=20

Applied to master.

commit f8488d16400888b5c5f599cc2eb6e383bf9dd589
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Jun 18 20:39:07 2012 +0200

    Remove ENABLE_CONNECTIONS ifdefs
=20=20=20=20
    Connections were always on for a long time. Note that ENABLE_MAMAGEMENT=
_REMOTE
    was only depending on ENABLE_CONNECTIONS and is removed as well
=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: James Yonan <james@...515...>
    Message-Id: 1340044749-10694-5-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6744
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig8C61124197C616A729BD6FF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/kReIACgkQDC186MBRfrq2fwCfYM5RdwzA4fbuNETpBhAL0ctk
FJoAn31guWMx4SrIURTPwKqk84m3UIkp
=bwHx
-----END PGP SIGNATURE-----

--------------enig8C61124197C616A729BD6FF3--

