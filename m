Message-ID: <5008669B.9070408@...1114...>
Date: Thu, 19 Jul 2012 21:57:15 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1342009010-9735-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1342009010-9735-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig04466F05E6CC3F77D70007B1"
Subject: Re: [Openvpn-devel] [PATCH] add option --management-query-proxy
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
--------------enig04466F05E6CC3F77D70007B1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 11/07/12 14:16, Heiko Hund wrote:
> Make openvpn query for proxy information through the
> management interface. This allows GUIs to provide (automatically
> detected) proxy information on a per connection basis.
>=20
> This new option supersedes the undocumented --http-proxy-fallback
> option and puts the responsibilty for HTTP proxy fallback handling
> to the GUI caring for such.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  doc/management-notes.txt |   31 ++++++++
>  doc/openvpn.8            |    6 ++
>  src/openvpn/init.c       |  185 +++++++++++++++++++++-------------------=
------
>  src/openvpn/manage.c     |   52 +++----------
>  src/openvpn/manage.h     |   17 ++---
>  src/openvpn/options.c    |  112 ++++------------------------
>  src/openvpn/options.h    |   28 +------
>  src/openvpn/proxy.c      |   15 ++++
>  src/openvpn/proxy.h      |    3 +
>  src/openvpn/syshead.h    |    6 +-
>  10 files changed, 178 insertions(+), 277 deletions(-)
>=20

This patch got reviewed by James Yonan, but he never responded publicly to
this list.  But it's applied to the master branch, as James said this made
sense if it makes writing the GUI easier.

commit af1bf85aee836f2b729c38990028c035b6c69152
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Wed Jul 11 14:16:50 2012 +0200

    add option --management-query-proxy

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Reviewed-by: James Yonan <james@...515...>
    Message-Id: 1342009010-9735-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6841
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth


--------------enig04466F05E6CC3F77D70007B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAIZp4ACgkQDC186MBRfrpcPQCeMNXqBcc4+Jm+M+kbgTAwm5UN
ytAAoIxhCwu3NP/D7hXB5k0sS9DJZvfq
=oa1+
-----END PGP SIGNATURE-----

--------------enig04466F05E6CC3F77D70007B1--

