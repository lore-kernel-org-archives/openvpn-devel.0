Message-ID: <4FED6322.6040503@...1114...>
Date: Fri, 29 Jun 2012 10:11:14 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
	<1332621070-28464-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332621070-28464-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8AC089D2823A468E0938BF62"
Subject: Re: [Openvpn-devel] [PATCH] cleanup: windows: convert argv (UCS-2
 to UTF-8) at earliest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8AC089D2823A468E0938BF62
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 24/03/12 21:31, Alon Bar-Lev wrote:
> Discussed at [1].
>=20
> Use wmain under windows, drop the custom parsing and shell32 linkage.
>=20
> There is no need for gc magic as this allocation is static.
>=20
> [1] http://permalink.gmane.org/gmane.network.openvpn.devel/5433
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/Makefile.am     |    6 +++++-
>  src/openvpn/openvpn.c       |   37 ++++++++++++++++++++++++++++++++++++-
>  src/openvpn/openvpn.vcxproj |   10 ++++++----
>  src/openvpn/options.c       |   27 ---------------------------
>  4 files changed, 47 insertions(+), 33 deletions(-)
>  mode change 100644 =3D> 100755 src/openvpn/openvpn.vcxproj

This patch has been applied to master through lazy consensus.=20=20

The patch has been tested and seems to work perfectly fine, and it have
been discussed in a developers meeting as a reasonable patch to include.=20
Thus no reason to delay inclusion any longer.


commit 74370aa89df9285a95084616e9c2d3c8464760b9
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sat Mar 24 22:31:10 2012 +0200

    cleanup: windows: convert argv (UCS-2 to UTF-8) at earliest
=20=20=20=20=20=20
    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Message-Id: 1332621070-28464-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6063
    Tested-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig8AC089D2823A468E0938BF62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/tYyQACgkQDC186MBRfrrAggCgpGRwWk0k3ET4IZHdMsgUwB0U
tOAAmwY+gPPJWbgOcmo4zWtMYAFWGGAH
=0WmF
-----END PGP SIGNATURE-----

--------------enig8AC089D2823A468E0938BF62--

