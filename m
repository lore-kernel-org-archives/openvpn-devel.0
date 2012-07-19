Message-ID: <500866B5.301@...1114...>
Date: Thu, 19 Jul 2012 21:57:41 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
	<1342542316-32563-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1342542316-32563-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF6F0486E432D8F9D6672F760"
Subject: Re: [Openvpn-devel] [PATCHv2 2/2] don't treat socket related errors
 special anymore
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
--------------enigF6F0486E432D8F9D6672F760
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/07/12 18:25, Heiko Hund wrote:
> WSAGetLastError() is just a wrapper for GetLastError(). So, there's
> no need to differentiate between socket related and other errors.
>=20
> This patch removes all special handling of socket errors in favor
> of simplifying the codebase somewhat.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/error.c  |    9 ++-----
>  src/openvpn/error.h  |    4 ---
>  src/openvpn/fdmisc.c |    2 +-
>  src/openvpn/manage.c |    4 +-
>  src/openvpn/proxy.c  |   10 ++++----
>  src/openvpn/ps.c     |    6 ++--
>  src/openvpn/socket.c |   56 +++++++++++++++++++++++++-------------------=
------
>  src/openvpn/socket.h |    2 +-
>  src/openvpn/socks.c  |   26 +++++++++++-----------
>  src/openvpn/win32.c  |    6 ++--
>  10 files changed, 59 insertions(+), 66 deletions(-)
>=20

Applied to master.

commit 910675de28956cf8d028aed727486b64747362fb
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Tue Jul 17 18:25:16 2012 +0200

    don't treat socket related errors special anymore
=20=20=20=20
    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1342542316-32563-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6876
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth


--------------enigF6F0486E432D8F9D6672F760
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAIZrUACgkQDC186MBRfrqW8gCgjRq0lh/b69nGVh1/vrapyGll
tbIAnjgAyPW/G3pzDURQM/9zqSNGuC2O
=hMOh
-----END PGP SIGNATURE-----

--------------enigF6F0486E432D8F9D6672F760--

