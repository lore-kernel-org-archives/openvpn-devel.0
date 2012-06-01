Message-ID: <4FC8C6B1.3070505@...1114...>
Date: Fri, 01 Jun 2012 15:42:09 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz2X_E=ODTGZ2mu-1Q1NkF4DaM=jLPoiKsDXmJ9KN3tZ6Q@...278...>
	<1336199983-9916-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336199983-9916-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2A816D7AE080F73C31804634"
Subject: Re: [Openvpn-devel] [PATCH 1/2] build: add git revision to
 --version output if build from git repository
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
--------------enig2A816D7AE080F73C31804634
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 05/05/12 08:39, Alon Bar-Lev wrote:
> If source is located at git repository, acquire branch and revision
> of head to be printed at --version output.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  .gitignore            |    1 +
>  Makefile.am           |   21 +++++++++++++++++++++
>  compat.m4             |    5 +++++
>  config-version.h.in   |    1 +
>  configure.ac          |   12 ++++++++++++
>  src/openvpn/options.c |    6 ++++++
>  6 files changed, 46 insertions(+), 0 deletions(-)
>  create mode 100644 config-version.h.in

ACK.  Applied to master branch.

commit 7046ff20f93eca1d850df43fe716922e6d105c1c
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sat May 5 09:39:42 2012 +0300

    build: add git revision to --version output if build from git repository
=20=20=20=20
    If source is located at git repository, acquire branch and revision
    of head to be printed at --version output.
=20=20=20=20
    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1336199983-9916-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6431
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig2A816D7AE080F73C31804634
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/IxrEACgkQDC186MBRfrrlWQCgj1AtuIMCMIeeNgZFm9t0LD0c
ivYAoIc1ibM74NO9r2zMVUcMt9sAHQ85
=9Nhj
-----END PGP SIGNATURE-----

--------------enig2A816D7AE080F73C31804634--

