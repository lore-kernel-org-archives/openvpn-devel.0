Message-ID: <4FE445D7.7070607@...1114...>
Date: Fri, 22 Jun 2012 12:15:51 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-2-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-2-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6664ED24BDBE6BCB745E92F0"
Subject: Re: [Openvpn-devel] [PATCH 1/6] Only use tmpdir if tmp_dir is
 really used.
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
--------------enig6664ED24BDBE6BCB745E92F0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 18/06/12 20:39, Arne Schwabe wrote:
> This fixes starting openvpn compiled as client only version of systems th=
at have no /tmp (Android). --tmp-dir could only be set if P2MP_SERVER has b=
een enabled too.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/options.c |    7 +++++--
>  src/openvpn/options.h |    4 +++-
>  2 files changed, 8 insertions(+), 3 deletions(-)

Applied to master.


commit 4690a1f269be877b5d114c59f54d87b6ebc236c8
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Jun 18 20:39:04 2012 +0200

    Only use tmpdir if tmp_dir is really used.
=20=20=20=20
    This fixes starting openvpn compiled as client only version of systems
    that have no /tmp (Android). --tmp-dir could only be set if P2MP_SERVER
    has been enabled too.
=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1340044749-10694-2-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6741
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig6664ED24BDBE6BCB745E92F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/kRdsACgkQDC186MBRfrokeQCeOMr7FtZYWdkrb+TReRf/ZPOg
5sEAnjoLXcpFv2EteTnuLThwL2fQylYT
=6zKt
-----END PGP SIGNATURE-----

--------------enig6664ED24BDBE6BCB745E92F0--

